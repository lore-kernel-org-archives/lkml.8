Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E593C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033042137B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fVwgyyI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgDGQjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:39:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:42221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgDGQjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586277573;
        bh=KDnY7+9cyTUORfefslSpVuilBVC7HemGqZGdd6Cz9tI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=fVwgyyI251NbZTILwBCXR4K6qQrBP/eruwXPz3J1sF4F6e3IHF5wA15DfAwXNTDY9
         xrWXkS36Geie8926Y881QMAayCLgMsclk+P1fZcgPLCC7IYU1SX4RdEvG6O/b24oC7
         /RzpJ0zR3yEXHL2YJZPpjYL+lFVuBSqGxesSm8YU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MhD2O-1irUWd1rRy-00ePF5; Tue, 07 Apr 2020 18:39:33 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] staging: vt6656: Cleanup of the vnt_get_frame_time function
Date:   Tue,  7 Apr 2020 18:39:13 +0200
Message-Id: <20200407163915.7491-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w0yevbcyk0crSmkW4QvrWRrn4IVxqoT1Occkris07LGxOIyTubZ
 KZMIBv9n6yRb/alAhKIcLMZROlUryBr4kq9DhbL+nBfPs+EVOwQhzW20s+Yf2r/h3Ndh+HC
 oIT+HUcXIHVfQScFGYtx3KBo5cBo6acgIK3QWe+eg2X8hnzUBVUQLDx5qgRZik/axEPgbcr
 3UDMFTU8/4Dg7FFfmWjEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y5zllwH5DgI=:RI69gCbJOCYG1KkS8Pm+PC
 JqujLrTeUlhUejIYn8Ak0AjsFBhy8K3OYXSFLCr3CL8BFS1+sx8ot75OqphdTObqOdrqht2AC
 p2wHPusfO74k91nOyuaxKreijBSGUFgyBLF2FFMF8cUB1kdsbStIG3nzjb9RfMbifEzsXEQHk
 tFM9sYrjxm/Z6cK8d7NtS/QePSogBbby9SNkSmnQrAmwv4Y6Osp8I2TIMz/vykz7Ix3t42U0U
 VhgAGNzaBoQUW0FZn75Ie3S6XZSDad3ocmWEROawMlUL2PURl/QB1Aa3ioBXzpyHKcWmQnxVk
 aqpYrmw0Rr4Rg+eu+xJqWAQVpQrwGwI3nGeyyz52UIO4v0MMEVtpgCNCKWG0byebzmaTGOHZt
 jTxx8qPnf+WWC1AnYYqFBhqxOKrrjCxoaFagif0LolUAeY7ENAbblqu0pnb5c0C0YYoitEZYU
 YNu1N+vG64PMqAXNC8vzaD2FBW4XRMVa83cl+xxC681O6wJKr1dGrKYqgEwoS76poFQu2k5hl
 qAEsLI+omVdYja0oq/z5QzZhz7EW7Ip3HpoR2vajIguUHKKkKvN57XVuBSxd40Z4MbWmVzmFk
 ajj6lrybBCqFialDCo50W73zEQ5dQmMqn/kVL/sICW2RiYNCM/nDBIm2PN5hVn0PtlaIh1Fey
 bTrD7t1RmC/5iZ7YrRsE7GIOMV+DvoM5aPF/fzFQrHh8Hb/bLLmQKc80hBA6v3b0xPi9KQhc3
 7sB0l0h9qw8n8NLxSbGHTrHcB96Rbb0RojrruGAOmciVMMkaZBneLljgCcLUhPtyGq3ouQFXs
 24xUhC8CdHUHPjXKLBoc+ELxAtyZK6YVUpCrub0R91q7mtdO5k2C2E+gDa76QKTajNS2kcHlo
 FgFH72BpvBBO9dv3d2IdNC/r3PvcaPlVttZvpibQs0XBHzY8XkVVRkAL3X+tMdjbyTBoQHkqM
 1DuqGQGvKlDeOBDoXcFzp1JcYG1nL3rbkzuiuU7GPNbewP46iCucnRkPYUagYm8CNqp1u/5Ot
 ZJDthoGy2utRixNqrPpnvIQ8FerUUVVHYIIQGzvmLtLHicNTymLKAleP3eZDcjm706Xy6V+pa
 rw4RCsNS1sgxNcMH88BsaGGkHME2vM/8hTZDM9uQ3G/J6wFUcVaFFNlPyHGm/gGoBqsOAJL9z
 5Q6crayq/HoIkpSPDSWNXFpu1J7kkCr+PcrO8uoiYZIiGMJR81qveItKgXS8r1xC3voMVXw6T
 T4YUzE2LNMTHXL8UR
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series makes a cleanup of the vnt_get_frame_time function.

The first patch makes use of the define RATE_11M instead of a magic
number. The second patch remove unnecessary local variable initialization.

Changelog v1 -> v2
- Not use the ARRAY_SIZE macro to compare against the tx_rate variable.

Changelog v2 -> v3
- Use the version number in the subject line of patch 1/2 and 2/2.

Oscar Carter (2):
  staging: vt6656: Use define instead of magic number for tx_rate
  staging: vt6656: Remove unnecessary local variable initialization

 drivers/staging/vt6656/baseband.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

=2D-
2.20.1

