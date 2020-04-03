Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4663C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BDC206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P97RgtAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404054AbgDCQGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:06:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45389 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404003AbgDCQGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:06:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so9117402wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oKzSBFHYve6VknNk6okjq2PNSvbSOu3F0bKJlTlq03A=;
        b=P97RgtAt+zkUMxdQJzNanmmUk/SfwXCVTeeA/RcjgcY7yAi45mAdp7WI5ZmfD9HWc6
         B9C+rkfhu2rQnJPhUEI0JX8A+iVN2vAMltq8qqRtCaFYAZ2wWxtpQgqa5ooiVPTIrrTf
         YFM64Wlx2G67pQhiebSqc84J80UMeoW/eK6CVu9s1DSZTX2ZN8y53qbNcFQcihA8Eq8E
         MChOg7hVs3KLsRxl4AmwuRbGjq7+W8lZ7gAS/rMuQc51d4SGh1uMCef+h+L+mtJrdxoB
         X7MHJwxG5yyfCRq1V4o3H1phkz/fRxFHG1uuNW7LBPQktNDIywsHrTsEB+pV+tIqwouL
         +Wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oKzSBFHYve6VknNk6okjq2PNSvbSOu3F0bKJlTlq03A=;
        b=t5ny79YXVQHlM6ctBxD5IFmsYPSEvuyQ0R/+VPwLa9b663ABCYLyRYp1fBhI9g9jEI
         6YuCw7cvPbZAxeC9zh8tOhGhv9ScqPGFZN11fXoaZ7JxAXFc/tYub1ceNbFDkNOzs3gZ
         eWgFCHTGQZanT7mw8jwKDK62Xs3evMp9vB5mCNaWwvFqG7C08B3uUYZXSbfBdvGm0m1B
         GE1jltBzUHsldBTFHWF5/WRlYN8uyivW0ncbRlYodHiRbzo0NCu3i71euIRbhLy0nTnX
         700Fx008/RthAlBLays/EN/FavhigT94Bowb8QfHhVdfxoTLKBplquzceWQaoEF9zGfu
         EPhg==
X-Gm-Message-State: AGi0PuYFBQS5xEnt0oCGG7I77mZQDdfa/HpqMGDR+GunCXTARR5MINVh
        KybE5G2/DDZE2w6cbVCSvYNbIUoFOdoi
X-Google-Smtp-Source: APiQypLUvf1tx2vZfsGhV0Xp/TYxgR7BJ/Ci7CFOSgCfLyPkqDSPscO8w1BtpBNb2LXSdFbFRdNBYw==
X-Received: by 2002:a5d:4f08:: with SMTP id c8mr10051991wru.27.1585929962472;
        Fri, 03 Apr 2020 09:06:02 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id l12sm12351426wrt.73.2020.04.03.09.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 09:06:02 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Corey Minyard <minyard@acm.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net (moderated list:IPMI SUBSYSTEM)
Subject: [PATCH 5/5] ipmi: Add missing annotation for ipmi_ssif_lock_cond() and ipmi_ssif_unlock_cond()
Date:   Fri,  3 Apr 2020 17:05:05 +0100
Message-Id: <20200403160505.2832-6-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403160505.2832-1-jbi.octave@gmail.com>
References: <0/5>
 <20200403160505.2832-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at ipmi_ssif_unlock_cond()
	and ipmi_ssif_lock_cond()

warning: context imbalance in ipmi_ssif_lock_cond()
	- wrong count at exit
 warning: context imbalance in ipmi_ssif_unlock_cond()
	- unexpected unlock

The root cause is the missing annotation at ipmi_ssif_unlock_cond()
	and ipmi_ssif_lock_cond()

Add the missing __acquires(&ata_scsi_rbuf_lock)
Add the missing __releases(&ata_scsi_rbuf_lock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 22c6a2e61236..030e7c09e44f 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -313,6 +313,7 @@ static int start_send(struct ssif_info *ssif_info,
 
 static unsigned long *ipmi_ssif_lock_cond(struct ssif_info *ssif_info,
 					  unsigned long *flags)
+	__acquires(&ssif_info->lock)
 {
 	spin_lock_irqsave(&ssif_info->lock, *flags);
 	return flags;
@@ -320,6 +321,7 @@ static unsigned long *ipmi_ssif_lock_cond(struct ssif_info *ssif_info,
 
 static void ipmi_ssif_unlock_cond(struct ssif_info *ssif_info,
 				  unsigned long *flags)
+	__releases(&ssif_info->lock)
 {
 	spin_unlock_irqrestore(&ssif_info->lock, *flags);
 }
-- 
2.24.1

