Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E8DC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 15:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62C82071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 15:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dtUI6W4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDYPSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 11:18:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:57681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgDYPSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 11:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587827906;
        bh=jinwy3zrH9UsxZ3tEHwtp3UM6YHeWfehz+l0ZpozMaM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=dtUI6W4S3nAvGnest769Io7PDw0Szl7Ot8yTgJSoou/JjjLUMi2TXOYlbK/32AsO6
         QRy4CbNBMbu/FbfhaKGO3AVs3bXZB5xRt8tKOlBUu60ADIBKjqCJo6EApbO7zTVmyk
         9pOWlIXzg5WosTjL9KwcgiQIDEepwySDUH5DmlDg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M3DNt-1jTk9U3Ej7-003cdB; Sat, 25 Apr 2020 17:18:25 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 0/3] Refactor the vnt_rf_table_download function
Date:   Sat, 25 Apr 2020 17:17:44 +0200
Message-Id: <20200425151747.8199-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rmWVld04s+Fu3pTwdTP738ZueO133wtJEO1sO1l0AofOKZcxWVQ
 WJ1OD+c+84OQD8uWBAYMX3aURCQnqBG4ZqsfFgp2lfIZnJu4K7/A/b5GTF0PyztEvzJi8Lu
 rVExGTjMbfzSiY0JY265NvEcvokGsLVSJejB7d7eang5rbBLTgmmQ4Qw0gPAAHNtE2JPuNe
 8UJvYeUWK8JD66qBZiKjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q5M185wis7U=:GLML2V8Er0JRJPPMvkxKmP
 /1jnEpRgdmYfyKuZzln8bcEGcE1u2EHOaJbefwguVtwtoM474fO4CO6vSDQSjEsKiznHDjDA9
 C2X3AxaFBn1KMKDbDbuliy2N4gMERf+OyKpmzV1B3sRlvY4zkOoE0MYnokbSREwdCGZdadZH2
 AAkja0BoZb869C7p7HUpoABs5OMbFzoBmqzGA18HYlXuAVo6GtI6/TPv3JFcPtDxCk+ku/a9T
 JiKs2TWeAVpWt/49wrYc0GHYpKIFrXXFj/WT1JfBKNqUBczn6zAe1lt2vfO2bbzttG9yG112g
 LZeFfU+gRbeJ2AjNu94FHxBDyTyIBF8TH54ebTRkZE9gj7wg7b0mg/7UcNXCOwAh7KXibeqq1
 SEzV91fXNKTU9AjBWRSbRHhOqqnoEXmWtww2iWvjhjVprgZlkI+pfbLPJKVFf+E+8biZ2CIOe
 sqYuqnwxH0ob2yY19U01M4rGXpcPMpLGg8YTc1nnx2czbeae+BHFKPvC9Drp13YWrvuKIMh5Y
 DpBlPEo7XaGnING5p2XgbjOI9QqMtccoC4N5LiNNliud9VIs+NqaUP/TXP56bFBH/gaesJmrE
 vhvWRrokpw+u8tprlXAmFifve8eP+PR9fgHvwwv3BcFmB0/4z6Dx/i9f34X3DsRrp0O4PGSvp
 kG4FkafEV2/4oQa+vLCmUiQbkk7u4Xb7QkecIAra4MSVwM+vnm7Z07einLnl068oCxLu1ydrk
 AbBamx2fx0Bwcpj/7K6h7RjIn1aqnFMUMN/z4GvQYaWmgrPoDfXNbC2HI76LFxQf0D6wDNBiO
 HqV7XLZvAi2bEb6wyUdFPrOD9k/xIpeDfOQ/aeKI2jLZpLKOJHVZ/+X9hgdnD+Evs9xgL1XPN
 W6hFjVqcwKGSvsiHRGoesOR+S+Miu8qjgfLeYbTwwxZYc9B5gEzJ28O2K8HCml4ERd6GlDdgl
 cMC2d8ADD17KtdgpxKSAtL0heckiJE2luS2rfd1ogojlrI4ZqAuOv1jBama6zsvXQZNlRGe2K
 f411S/BTrRK52ys6WzjzoN4Wqnmn0ESEMIiO8gmPrwCzemldLh59iLgCLHRP23ZPcVYpr9c29
 GEtdZlD+4epWOydbonRllkcQgKXeMscP2c42Q/wFA5OUs+Ej+J3JO4TFFDS01yCZrcEgit7uI
 St6yxOBk2o3APXP4KGyIJUg1NML+LAAQZLxmoUs6IVBQ2qTPcrG/bkWqSuo9G1FNWPnJMbii2
 tacBHVM6ZUo4MP58d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series refactors the vnt_rf_table_download function through
tree patches.

The first one removes the local variable "array" and all the memcpy
function calls because this copy operation from different arrays to this
variable is unnecessary.

The second patch replaces the "goto" statements with a direct "return ret"
as the jump label only returns the ret variable.

The third patch replaces three while loops with three calls to the
vnt_control_out_blocks function. This way avoid repeat a functionality
that already exists.

Changelog v1 -> v2
- Modify the commit changelog of the first patch to clarify the change as
  Joe Perches suggested.

Oscar Carter (3):
  staging: vt6656: Remove the local variable "array"
  staging: vt6656: Use return instead of goto
  staging: vt6656: Remove duplicate code in vnt_rf_table_download

 drivers/staging/vt6656/rf.c | 85 +++++++------------------------------
 1 file changed, 16 insertions(+), 69 deletions(-)

=2D-
2.20.1

