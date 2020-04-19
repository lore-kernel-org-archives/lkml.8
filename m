Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10498C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 10:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF0621744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 10:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jYncgqpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDSKtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 06:49:07 -0400
Received: from mout.gmx.net ([212.227.15.15]:34387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgDSKtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 06:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587293325;
        bh=3jAo2O3TXaZEMKOZIe9E3hE/PYAWmrtw7jQ9+z5eaJE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=jYncgqpe8y4utXxE+6eQ2f610VSV60Nojmu9lZTaiewd29d0qRmVMlpFe5TbWzwgc
         oIae0d73VxkS3iElZ52ujljqdoEdy3iXH3jqAZFEPwicqxrayEm9NpOXKICmZRm+0o
         See+J6wCGr2P1b0CMVHQDsLrgI5nXavT1pSuv6vs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1Mz9Un-1j5AmE0mP5-00wCkR; Sun, 19 Apr 2020 12:48:45 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] staging: vt6656: Check the return value of vnt_control_out_* calls
Date:   Sun, 19 Apr 2020 12:48:19 +0200
Message-Id: <20200419104821.6127-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jr0uXI0eYb4k4tV/gk2x4YSRsAgSc7y3yCVahYpded4aybrF7wh
 YgpHxv+mEFJKfx/ecf0p8JLOQUfBhv1Xp9FFR8grC/OEhPmFH3+KwcJmxmKMgtnWArpuagK
 Uju8g4b7vHTrLHN6/xCUYei8Efu+/klpBFvK+OfAxP2a9suzZPN7Suoe5sG2+jePVOzJ1Lv
 +57xbnmJfrA6Ym85LYtFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o/Js2WZO5M0=:e2R2N3P1srnFYT2n5WForO
 JYTt0kzHdRB642tbU1aGHY1uLWtjnp2Fru5cbfXGIzphSyyrWGV1RIejJD6vtTLakkZUpgHSI
 giaHICMecJN4IL/4hqoQ9vxTCjiDPSbyDheKsmsCqgkNjftCDcXzu1cTdwI1Tv6A354HfiyDU
 ySthGKlo4sKY/y3cZQwqgG2zMSPGMjYQjWgEWodikklBhYoN5ALb6NbIzR6xQIEZd3wEYua2y
 egqLhAZf3S+001RN+Rj36HofxdPNlQ6vAUNTei/0W38L2bFpyGQTg37TR19hyOzBJduXIR7Uv
 BxzecpCmzlEfcxJ3vVzZITIhRxCZGA9AzyFq/YSl/pg593eeuH5hkIz5b28QS8t33M+gZw88S
 jpZlTUIzahQDRAT4oYtp0f+WrT17N8HMJWg9wP6iuezAb0KnqHYoaMrOhrzjnG9SkbQQj1NYv
 SeQKSKT5XSfKMhmDoSOH9EnCZemJRse0dyzzs+WJUXSYd9tNWDSDFfshdI1YH/9Tsq/d1MWji
 7dpbCQbmePy/uTUWsIZRcF4bCzChwe8k/DHkzDVJ2d+dYtBET3ixMAq3SIOa4ItXGJ7nuYug4
 L2moOWALVCapIn9xm2dBpoBvSS/sYcsLIjYhgzIFpdv9cqsx0qQzyuEiPPAYWBCoDCTLUGurn
 FrmNP7BG0iEMWe/m3Af8QOUXkF1GTh0eX1b5TaLI5F3IfGwcMnke/9jK7Y3c6msDcLaIHiRA2
 NbQ/V7AEZF+rQI6mMFfjLzDFVT4jfJ6FrDeB+6rhYW/94Nr4pv1L0UIaK9CEBQ2KGe5xAWHNg
 iEK54x/1cfwqo3pufXXIj0Vn6vo2s+g+wlAC0OujneZWEMOXeMfx2wlnBQxD8zPR89POX+Rix
 rEHkSuGPTVU76cnjlzKQbBrQ6ZdhMNM/3hOEif3OvMaxkCYraFAOV+btub6xmdOnmmdCTmkYw
 ngmFya5ssoZGuc22bslqngbTVA/txpBSV9MIoprFQK/vXXUznlLFP4hnQoVXYTKWi0ay1i/ir
 aIoSJCAmSuxmxiHokTUml0xL5fY5MW2o4sGC2U3TNVuAiVHo+njoC11mrgVpfdiAOP9UAeTpc
 JbTGIRHINqvMP30qljbzVqfr4kRux2CmSrsh5FeRJUHVRp16DnFgMH8eKpJVrlXy67/6NzeOW
 9eirxFIrEpZDMCfC9w9EYhC8VpoHBzW9EpxAu8GeDGcKLY/ilayWRI+keOnOa3dqWWU0mT3DW
 vyulUpJS7c866Yn1Y
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series checks the return value of vnt_control_out_* function
calls.

The first patch checks the return value and when necessary modify the
function prototype to be able to return the new checked error code.

The second patch removes the documentation of functions that their
prototype has changed as the function names are clear enought. Also,
the actual documentation is not correct in all cases.

Changelog v1 -> v2
- Remove the function's documentation instead of fix them as suggested
  Malcolm Priestley.

Oscar Carter (2):
  staging: vt6656: Check the return value of vnt_control_out_* calls
  staging: vt6656: Remove functions' documentation

 drivers/staging/vt6656/baseband.c |  35 +++---
 drivers/staging/vt6656/baseband.h |   4 +-
 drivers/staging/vt6656/card.c     | 176 +++++++++++-------------------
 drivers/staging/vt6656/card.h     |  18 +--
 drivers/staging/vt6656/mac.c      | 128 +++++++---------------
 drivers/staging/vt6656/mac.h      |  26 ++---
 drivers/staging/vt6656/power.c    |  22 ++--
 drivers/staging/vt6656/power.h    |   2 +-
 8 files changed, 156 insertions(+), 255 deletions(-)

=2D-
2.20.1

