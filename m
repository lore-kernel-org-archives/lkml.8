Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1459EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D842B206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgIAKYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:24:14 -0400
Received: from se14-4.privateemail.com ([198.54.127.71]:43938 "EHLO
        se14-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgIAKYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:24:09 -0400
X-Greylist: delayed 4387 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2020 06:24:09 EDT
Received: from new-01.privateemail.com ([68.65.122.22])
        by se14.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <javier@beren.dev>)
        id 1kD2JV-0002RT-G2; Tue, 01 Sep 2020 02:10:53 -0700
Received: from MTA-12.privateemail.com (unknown [10.20.147.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by NEW-01.privateemail.com (Postfix) with ESMTPS id C82FE60047;
        Tue,  1 Sep 2020 09:10:41 +0000 (UTC)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
        by mta-12.privateemail.com (Postfix) with ESMTP id 1CD0D8005D;
        Tue,  1 Sep 2020 05:10:40 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.207])
        by mta-12.privateemail.com (Postfix) with ESMTPA id 2F7388005E;
        Tue,  1 Sep 2020 09:10:36 +0000 (UTC)
From:   Javier Garcia <javier@beren.dev>
To:     corbet@lwn.net
Cc:     rdunlap@infradead.org, grandmaster@al2klimov.de,
        billy_wilson@byu.edu, tony.fischetti@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Garcia <javier@beren.dev>
Subject: [PATCH] Documentation: process: step 2: Link to email list fixed.
Date:   Tue,  1 Sep 2020 11:09:49 +0200
Message-Id: <20200901090949.14514-1-javier@beren.dev>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Originating-IP: 68.65.122.22
X-SpamExperts-Domain: o1.privateemail.com
X-SpamExperts-Username: out-01
Authentication-Results: registrar-servers.com; auth=pass (plain) smtp.auth=out-01@o1.privateemail.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.08)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0VKALJWqpbz84ezJUOplsTqpSDasLI4SayDByyq9LIhVIuQF43nnBMRX
 MP08rPosJ0TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K8BDv5Ys6stOQKuhUsdyE/YXh
 jScmTpVv5IonvxmB5O2cLC1IK8e+Ehvc2ewaYOyqLDmknkFCtrExuxg140V9nMQADXLdBQ+nLlc/
 tA4Sj9OZ3L3pjRPMgR642BMqzMTpdD5k9W8Y1NI1olsN2+X6tW8f5KzuRwo/u4ywWX5sXihWdYve
 LjBT1D2OrZqPRZiV+tkmU+/KX0nJnQyIUdcchsZB14E0iQtvqvjtp9rD8IfSSTIqPFW0EznUJres
 HIC6dmOq8/idP5dSGXlfHvUTLiTg127TqHZDxA/kZB41Rh/voK34s6CNmUeOB0vgUWUzE9aykhW0
 8S2Q9BZfV4rjkuGF6ePhLVNfQ99xpFdqMeNulR8PV9sblK50edB8qs77GrXdW109g+lAMkAbyNlo
 TmD2SPbyZg7C0RNzNzUl0hPX/5RQ1HtujZudOVdkqb3xdfogTEiyipNb7Us9zHswFHAQhDClaeZ3
 9G/lq5mRCb4Z9Ey3vmI3Pf8Lyj0qFPdM2eJGTkj50kHu0eP3+1tcOW5Gb3kL1+ScpijA9VJdIVZb
 7VBYLa6SImlWmEsHWCOKqycb0ySQ8Q07QZMExH8QT39q0aZI3qbhXsaDdLgW9bprwAm+Udkqe7Lp
 E2Hbbj4OR1THjBWZFF00ALVWc/sntqhVr03UHlrscRrHorFm3BMamUdylUIKhf3z2GAHxH7IVEmg
 Qguj/lqkiC7ysrrDB5+6T7ALZGg9YLgY4aE4PatIT5U1N+BGv6dnx6KLDRADCyAuqK3fwzkfwU8H
 tX9oG/hw5BrSTYo8TxfzGzupTiaBDudO1dDoXig4TwvcULI7uP1eRabXi62XkKnwoNEefWv6ViZL
 9FCh/jIOcMlF46KNFdtqMvNGFbSZmdAMur/jYg8E23qlZg9I758Jzz+FbLwq2QQraYe+zAzhh4qo
 6jj7LEO/oCofTKVeJ/7WMCTsrjj7zXbV00TFoWVIRaGUZ61JS1wPrYDD/ctpiLRIW50zenHiZyHp
 r4AKKQd4IGQ04A7VxFLPO2D4Ht1VWvy1QT999TZxGwd1aPlvUNMk2g7ooxwbXsRR+vzvUHpiFqCM
 KokzYs+OyHavH6lgRmVX2PVSNSRLgqDi+US6XMgTGhTPGZb0dYXfvI9I/tmgU3euMS+4ayUpOtEh
 dxekWDmK9g==
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the past, these email lists where located at lists.redhat.com. This
is not longer the case and they are now at redhat.com/mailman/listinfo

Signed-off-by: Javier Garcia <javier@beren.dev>
---
 Documentation/process/2.Process.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
index 4ae1e0f600c1..e05fb1b8f8b6 100644
--- a/Documentation/process/2.Process.rst
+++ b/Documentation/process/2.Process.rst
@@ -405,7 +405,7 @@ be found at:
 	http://vger.kernel.org/vger-lists.html
 
 There are lists hosted elsewhere, though; a number of them are at
-lists.redhat.com.
+redhat.com/mailman/listinfo.
 
 The core mailing list for kernel development is, of course, linux-kernel.
 This list is an intimidating place to be; volume can reach 500 messages per
-- 
2.25.1

