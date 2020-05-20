Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F41C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D44207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589960461;
	bh=fov+5ZAYC3Ejkwb00u9X7W9YQjKrMIXgfLHkPImHt8g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=J6uceqREZlaI4xdsRoU1KRxjIHpnHOt4XHvl1/y8FO58YDN/HUs4gpM+i7HGuml/E
	 TCS9kfnqhYmwRsAsqjR6caqYi/uRX55W9UX0TwDFo+A5jqyrgyHBXZlPAyUk9FwscD
	 yPxWvTFpHH7vFkKs+FzNlNFciGZd/2kqiW10QKdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgETHlB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:41:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34691 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726435AbgETHk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:40:59 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-U9-Y8UJlOdu0jcY7-C2i4Q-1; Wed, 20 May 2020 03:40:54 -0400
X-MC-Unique: U9-Y8UJlOdu0jcY7-C2i4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37645A0BD7;
        Wed, 20 May 2020 07:40:53 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A79D7958F;
        Wed, 20 May 2020 07:40:50 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf stat: Fail on extra comma while parsing events
Date:   Wed, 20 May 2020 09:40:50 +0200
Message-Id: <20200520074050.156988-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ian reported that we allow to parse following:

  $ perf stat -e ,cycles true

which is wrong and we should fail, like we do with this fix:

  $ perf stat -e ,cycles true
  event syntax error: ',cycles'
                        \___ parser error

The reason is that we don't have rule for ',' in 'event'
start condition and it's matched and accepted by default
rule.

Adding scanner debug support (that Ian already added for
expr code), which was really useful for finding this. It's
enabled together with bison debug via 'make PARSER_DEBUG=1'.

Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.c | 1 +
 tools/perf/util/parse-events.l | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e37a6a3e6217..d251c8a778b8 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2014,6 +2014,7 @@ static int parse_events__scanner(const char *str, void *parse_state, int start_t
 
 #ifdef PARSER_DEBUG
 	parse_events_debug = 1;
+	parse_events_set_debug(1, scanner);
 #endif
 	ret = parse_events_parse(parse_state, scanner);
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index c589fc42f058..394132254447 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -252,7 +252,9 @@ modifier_bp	[rwx]{1,3}
 			BEGIN(INITIAL);
 			REWIND(0);
 		}
-
+,		{
+			return ',';
+		}
 }
 
 <array>{
-- 
2.25.4

