Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B188EC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB0E208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055944;
	bh=uF8p+kKfTbQZnrrDmwGuexdP/vbwIBhvNjHnVVCYJR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Glmpp49RZOp0MjL7zIWHX/DEtGpV0/8BSLN+EG3H7fX9mAOcrk8iw5E0dnm0qX38N
	 kbTd+QR51nn4zbquJqOehSbsPQVshHk+k4FxhJ1hmuIYbEMfcTTmQdzki9fV9VnE/K
	 S9I8nc1UdXWSU/IHS/AXdGuLeYYHY80V3hJW9gl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgCXNTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbgCXNTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:19:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5DEC206F6;
        Tue, 24 Mar 2020 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055940;
        bh=uF8p+kKfTbQZnrrDmwGuexdP/vbwIBhvNjHnVVCYJR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PbYiU7C4xN6u+gZcHZ9zM7cIc4rq6Zo/JC2WMu/Sd4AocqTQeVWqH/NXyxamW0rfz
         Le0PTKlWqXKAsQehajxWUsGcnjjDu6K34awZ7joeriomwyi0hMPQA5bL5xLE5EdMtz
         jY9JetOewlV0DQpM2y6/jrL8wtObPVb1jokpgC7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.4 074/102] intel_th: Fix user-visible error codes
Date:   Tue, 24 Mar 2020 14:11:06 +0100
Message-Id: <20200324130814.065022480@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130806.544601211@linuxfoundation.org>
References: <20200324130806.544601211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit ce666be89a8a09c5924ff08fc32e119f974bdab6 upstream.

There are a few places in the driver that end up returning ENOTSUPP to
the user, replace those with EINVAL.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Fixes: ba82664c134ef ("intel_th: Add Memory Storage Unit driver")
Cc: stable@vger.kernel.org # v4.4+
Link: https://lore.kernel.org/r/20200317062215.15598-6-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/msu.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -761,7 +761,7 @@ static int msc_configure(struct msc *msc
 	lockdep_assert_held(&msc->buf_mutex);
 
 	if (msc->mode > MSC_MODE_MULTI)
-		return -ENOTSUPP;
+		return -EINVAL;
 
 	if (msc->mode == MSC_MODE_MULTI) {
 		if (msc_win_set_lockout(msc->cur_win, WIN_READY, WIN_INUSE))
@@ -1295,7 +1295,7 @@ static int msc_buffer_alloc(struct msc *
 	} else if (msc->mode == MSC_MODE_MULTI) {
 		ret = msc_buffer_multi_alloc(msc, nr_pages, nr_wins);
 	} else {
-		ret = -ENOTSUPP;
+		ret = -EINVAL;
 	}
 
 	if (!ret) {
@@ -1531,7 +1531,7 @@ static ssize_t intel_th_msc_read(struct
 		if (ret >= 0)
 			*ppos = iter->offset;
 	} else {
-		ret = -ENOTSUPP;
+		ret = -EINVAL;
 	}
 
 put_count:


