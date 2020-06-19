Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EDCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ADDB20734
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592585624;
	bh=wiiAPxDAcgLdZnc+pWOGvgVltEwCs8Md4gzwodKMssw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yud/yuxSLUnSAHhRgwjs0ZbpUUXThG0PDeVwSsx8tRKZoZOuDkQb86Dc+NtQc70I7
	 q9l/euexof+7ZyHvcjV2qCwvT+8KFmsCy5ga4uU1ddY6DrdT8ix6XFt7k77HWuiKKT
	 NB4Rh9URqqlY2eo5w27GmLShBZtePtlaLH0W4Ts4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbgFSOhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387623AbgFSOgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:36:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A63C208B8;
        Fri, 19 Jun 2020 14:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577414;
        bh=wiiAPxDAcgLdZnc+pWOGvgVltEwCs8Md4gzwodKMssw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHSUdCdK6p65Ku3TLhlyCCRSM0mGThMVF8Lekyy2NhUvEL1Tv0myD00W/pjNeVlHv
         lL+7DxWsbo76i3+3nIhw3j1VSSMp6Cmkz6xK41c9jc0DdNCunWKmZiW1awZvsiWI8C
         SHSV462OuJ+ZnaZ3XEFUBiXYmzdmls6HVb/CSJCU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        syzbot+bfdd4a2f07be52351350@syzkaller.appspotmail.com,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH 4.4 042/101] Smack: slab-out-of-bounds in vsscanf
Date:   Fri, 19 Jun 2020 16:32:31 +0200
Message-Id: <20200619141616.316549056@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141614.001544111@linuxfoundation.org>
References: <20200619141614.001544111@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Casey Schaufler <casey@schaufler-ca.com>

commit 84e99e58e8d1e26f04c097f4266e431a33987f36 upstream.

Add barrier to soob. Return -EOVERFLOW if the buffer
is exceeded.

Suggested-by: Hillf Danton <hdanton@sina.com>
Reported-by: syzbot+bfdd4a2f07be52351350@syzkaller.appspotmail.com
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/smack/smackfs.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -912,11 +912,21 @@ static ssize_t smk_set_cipso(struct file
 	else
 		rule += strlen(skp->smk_known) + 1;
 
+	if (rule > data + count) {
+		rc = -EOVERFLOW;
+		goto out;
+	}
+
 	ret = sscanf(rule, "%d", &maplevel);
 	if (ret != 1 || maplevel > SMACK_CIPSO_MAXLEVEL)
 		goto out;
 
 	rule += SMK_DIGITLEN;
+	if (rule > data + count) {
+		rc = -EOVERFLOW;
+		goto out;
+	}
+
 	ret = sscanf(rule, "%d", &catlen);
 	if (ret != 1 || catlen > SMACK_CIPSO_MAXCATNUM)
 		goto out;


