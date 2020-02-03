Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EB0C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8677020658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Tph88dQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgBCUND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:13:03 -0500
Received: from mout.gmx.net ([212.227.15.18]:34959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgBCUND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580760771;
        bh=nNeQItQUTS/3R69QZ2cn9gLXMhnODkA9vJ3hblPDhMw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Tph88dQD+2YKYlkW3GdRAl8pHgcE/BO3LqlSaNUgJ3p6eFCLhEHNKfGZoKZp/P235
         0cuD+IImyuiAiISKwC8wmeD9mx3emwxIRIMHQVMcNQfI4RCm/0C+pyhfTsXTT1WXYO
         ES2QvuYBfldLctBot0GRJaEbXHJ9vle/iuPCCBHY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from nb-georg.home ([109.104.42.236]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mKP-1jawJd3SNH-017HiP; Mon, 03
 Feb 2020 21:12:50 +0100
From:   =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
Subject: [PATCH] platform/x86: pmc_atom: Add Lex 2I385SW to critclk_systems DMI table
Date:   Mon,  3 Feb 2020 21:11:06 +0100
Message-Id: <20200203201105.11659-1-georgmueller@gmx.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7aDMSWN4Q6tXxbGw3RGaTJx+IWiM+9FvUXRbk9nESpxfET35X8X
 SSLkWfYYFl7dkTx6sAgkITavfIjGZLUN3hfLzca0UBiTrykj5GfTzHOJ2VPemsDKYCtqnBl
 dqbmGdgod1b6SHvYLkNFboBcYJujE5qHFxHFdaEXwzRQzr8jdIIH7TOPoP5EO5/w08fTh3Q
 mgJPvzgCQ5PxDC5VDnqUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z0i7XLgqHrY=:wCkrryV4wUGggSToybGOy6
 Q2FO4uz3fHGs0LPxXTaouPnfVNrOVEfC3z3kjFQmk88LF17+eymbVeAjUwSinK7RBxG+obp5W
 VAfHr1sFNqvTnIJ9PJa11BdG2yLbl1LREkEmYBEm40kOP0w3P79tcL1f/PXkaUbJYk4FBy0vl
 HJOaZkysmawvo+HqMK4KyEOxGQHVQEpKixMQnx3Rzla0KN5Wr3lcbH/sgS95u3vzW3Szb6EzG
 7vJ5w2Wrd2k+xanNGcF40pLGO9JIu9tAd0g8apB34nP2VRoeutBOdW/acZdmRBDEGkisBJSPl
 W83XZOLg9e8mHpVZGtCcxkl0+ci1/MFx5Mam+ShG9KNPZCRQi8KBsw7RxrjlgDcUByq4lRV4+
 rNN3UNEoBd/2G0SIa2INYGjche/Yl5JnPglMg3GreVdISo5dfuNVD0EKhId3uGfgPZZLVk3zM
 6r1q2SF4fQL78PTWv9K7jMZ+WaJS6nEoFYTT6lQXuTWvVINesGLRTIugwPLMdfphddGRl+YR8
 OkbGT92G8ItRNsuyACYkD4Xdi11OWFiBbRMFG6BTguSK/6396A7zPSAvAlkzP4/BCq2mnsEZ0
 1uoaBPZ9HkzOGGAeSpbFiqqyX47+zPSFu2+z5ykMkhCeQCVOF6mIfEI2dsLegi+l4m8DoGr4G
 18TcP+bpwnYg8Lhznx5uN2FBLJFtF7hsh2HJZI/e3M41oAGla2/ryTLEEg0ppbDqH22aEG6Ee
 9C6+QvU2iwu+XAlhgny2mG8FUnNN7uHy53y1HCddSu1caLFIR7hln6vcw/KFDHKJpPYmtT6g/
 pmwfclsT5Y15C0jKQCndyulR0MBWyTq9HoaMJStfGMZAUau2BqCZJQE1pdympTY+0ipU1Y3tz
 4igkV6Q3m+bE5ZRExoRTfZlO7fYp97jK7ENu7bD6XiD1WhMa72wLjUfJvIQ31YplpWT6dyeQB
 EKAvuIUklyAXk6Vj4qNuqIK8oTq44KVPCqzP08XMBehTlNBiJztyfPfKjz57z6PCFXXhdDJJR
 f3K8w0I6R9ByHCHTkcM36nTlZOsVFn3PUn7TEW8PHU8lh6kBzU3z6liwqD2Rc4/801mPhbhAe
 YAZ8ulo9/EK1PtcH8gRmyX8cqnxbjERSYu8fO2cnLMvo7dBtCt7QPx4rqKarswVZ5maSL3mWV
 /Z9YKXabnSFpJQhsWO6wR7mqOInJWEWQY78P0bbEuP9a3fv42oEyDTBCXmS4z/VxvqR/Wf5ZT
 INL1oVyck0ygMcavk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lex 2I385SW board has two Intel I211 ethernet controllers. Without
this patch, only the first port is usable. The second port fails to
start with the following message:

    igb: probe of 0000:02:00.0 failed with error -2

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Tested-by: Georg M=C3=BCller <georgmueller@gmx.net>
Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
=2D--
 drivers/platform/x86/pmc_atom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_at=
om.c
index 3e3c66dfec2e..ca684ed760d1 100644
=2D-- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -383,6 +383,14 @@ static const struct dmi_system_id critclk_systems[] =
=3D {
 			DMI_MATCH(DMI_PRODUCT_NAME, "3I380D"),
 		},
 	},
+	{
+		/* pmc_plt_clk* - are used for ethernet controllers */
+		.ident =3D "Lex 2I385SW",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Lex BayTrail"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "2I385SW"),
+		},
+	},
 	{
 		/* pmc_plt_clk* - are used for ethernet controllers */
 		.ident =3D "Beckhoff CB3163",
=2D-
2.24.1

