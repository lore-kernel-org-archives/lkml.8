Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB29C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0D0206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443516;
	bh=oBIkwvkWSfSaIPFaRd38+MCP5MdNKN11rWJETiWECyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H5cHYKGvuZul0F3V7ydXHLv6s40cPBQAzsadOEmF7mmB5X0oLEYlFVDzti1Pg6c5+
	 Yu3EzKcBjwTzhceIV4xPXUC0zzLxqfQZy4HgQzxd8Wmt3IhlRDRnu+rkHQC1Y0pqvp
	 hqAGMvU+GZNsxaqsCxNYebx/JZ0srX/3uJLMRdRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgCQLLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbgCQLLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:11:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC76C20719;
        Tue, 17 Mar 2020 11:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443511;
        bh=oBIkwvkWSfSaIPFaRd38+MCP5MdNKN11rWJETiWECyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r/Tb7Nmxq0g4j2xY0xUzD8IZj8EGMkCg4LtNg6aax3vraDJbMwkv9O/5UIdN7VE0J
         Ehp28uOk/Jh8N/ItN/c1AirDVw7xExSQKy09Vz1aRi/dt36WALq9K34tz0HwHRV39a
         NmHo/QQGqagPw3MVGC2zDpGG5JKHmcbnrrGcvKwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Artem Savkov <asavkov@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.5 107/151] ftrace: Return the first found result in lookup_rec()
Date:   Tue, 17 Mar 2020 11:55:17 +0100
Message-Id: <20200317103334.059635900@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Savkov <asavkov@redhat.com>

commit d9815bff6b379ff46981bea9dfeb146081eab314 upstream.

It appears that ip ranges can overlap so. In that case lookup_rec()
returns whatever results it got last even if it found nothing in last
searched page.

This breaks an obscure livepatch late module patching usecase:
  - load livepatch
  - load the patched module
  - unload livepatch
  - try to load livepatch again

To fix this return from lookup_rec() as soon as it found the record
containing searched-for ip. This used to be this way prior lookup_rec()
introduction.

Link: http://lkml.kernel.org/r/20200306174317.21699-1-asavkov@redhat.com

Cc: stable@vger.kernel.org
Fixes: 7e16f581a817 ("ftrace: Separate out functionality from ftrace_location_range()")
Signed-off-by: Artem Savkov <asavkov@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/ftrace.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1552,6 +1552,8 @@ static struct dyn_ftrace *lookup_rec(uns
 		rec = bsearch(&key, pg->records, pg->index,
 			      sizeof(struct dyn_ftrace),
 			      ftrace_cmp_recs);
+		if (rec)
+			break;
 	}
 	return rec;
 }


