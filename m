Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7481CC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484D92075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217007;
	bh=xaB+BigCnNz5M2Ho0xbyBqqk1En95uljjZwy5BZucu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1itZIe24cosbVKCUuHTEYCAHpNo0+XYjh4x3zbLVo+IJzk+dMUZfrsUA9LI4MHeUA
	 lGbKvMfjRFM3RNZuAhaShU6USZlt6WML033SZWCzSkhIx1qr3RE57H4rqS4xPKV+Hq
	 FfFf/Bcy8JA3T3qJg3yTANTf5ovwxmP5j/JjDUcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389430AbgAPXX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:23:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390998AbgAPXXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:23:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D16F52075B;
        Thu, 16 Jan 2020 23:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217003;
        bh=xaB+BigCnNz5M2Ho0xbyBqqk1En95uljjZwy5BZucu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xCGNFy2ZMm1c2y7zr1apDCsdPXzpwVIgg613nxNmCP8j7QuAXjlfUXNXwARLN9/U6
         du4XZix9k66FUjNLzh7vVpDXUcRFlmTdI005XCMN0ptsSoORIFuzeS5NrZotVQEpMS
         NNSdqU1vP+U6RVx1wIMdpG9gKjlkxL8jfG/yCb6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.4 092/203] Documentation/ABI: Add missed attribute for mlxreg-io sysfs interfaces
Date:   Fri, 17 Jan 2020 00:16:49 +0100
Message-Id: <20200116231753.725821011@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Pasternak <vadimp@mellanox.com>

commit f3efc406d67e6236b513c4302133b0c9be74fd99 upstream.

Add missed "cpld4_version" attribute.

Fixes: 52675da1d087 ("Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces")
Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/ABI/stable/sysfs-driver-mlxreg-io |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -121,6 +121,15 @@ Description:	These files show the system
 
 		The files are read only.
 
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld4_version
+Date:		November 2018
+KernelVersion:	5.0
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	These files show with which CPLD versions have been burned
+		on LED board.
+
+		The files are read only.
+
 Date:		June 2019
 KernelVersion:	5.3
 Contact:	Vadim Pasternak <vadimpmellanox.com>


