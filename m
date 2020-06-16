Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0156DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE58820767
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZhtBy3Z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgFPKkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:40:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:59289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPKky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592304027;
        bh=6SOf7NEF+LzgefvtjKUN7BLHiKqUHsGrTowPCSTJeFU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ZhtBy3Z9k6cHZTKeDCBP+KZrmcTMx2BBy/RSGYCmJlHksc4/1DVNLp53zmlAQI1I5
         dI3HQVAqDh94+XDRK7hXZQsZ4nJXBSbW5NbhfJ4fbAtg6mke5I+AgkweQUprXjcoTn
         omUmArD7yDpwo+AnVDl9MpaTyIlmm6DUQzRq47KU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([109.41.129.180]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1Mkpap-1j2iKC1pvT-00mOHS; Tue, 16 Jun 2020 12:40:27 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] doc: add novamap to efi kernel command line parameters
Date:   Tue, 16 Jun 2020 12:40:12 +0200
Message-Id: <20200616104012.4780-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x2sTVS0pRRGb4d831aKJVftmf5hsUHn1SwnySUt9DG97FwRYPen
 QfCb2kow+hdULOuQXV0QgGoj62TJl74Au8sCXxAebCxU5uCYk8oWqinhE2i4vJHJgofnMet
 uGRroDwIzSSj3TCA0Rl4RjwkjhN4g5HyVZ+g74akTo2U/cFIgKuuA5wDbDA/uf6ZAGcvm3X
 3k3VFQCveI9tBH1gFz8XQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QzFMo5PuyFk=:RMp7+zpwucpQi+RiPXTPgw
 noAh0vLKdA8R4I20S4IczBc50eovyvwJ3Ajd86ivS/jtIuKjgUD80tBI+ttlHpvAO8a0nLUB6
 VswsYseFL8tJyAuNX2ZtgcPJGwFIlxUVeUe+tl+md0pt73iKqVFPa173leABeF9SCojkxbxD2
 vLTuSFVUAJd/vCvssEfqBu5eP3l+DjOovNRgRQxWhGP3PpXiLghFjMg4Dm3YfhIhUG+VqaRpo
 VhA4vedtFH2RlXWj2ofenh2ra0LAb2Shy7p37cWWXQG5U18yCG9wlshDMfeoPzYjhsiZAfWrc
 ODwF7Vkkt3nlmtXmJZ4B2dJ2hk2F5h2guYJlpfaxfFEEh6+FRDpp4hCuaRCQFMqlbwGl0ov7p
 ZtW/bmXReN47P02tPU8S3eZiYGJQMKAkFoPL+JoJO6sy1Axn4v3F3ChmqRwtCfmFNqg1I++Ur
 hdTK0wPcOZm3/y3vksRoEzJnkq1JfhOLg7Z9h9Ip7Kb5UHVXMeRGn0vufzAaGrsO/38L2LiEv
 Y93sZQgmR+WjWHtSYaI9ZB8hii1pOhLJGK0WubtWtjKa1KEIREA53Q2mbvKnR0MhD8X4yfECE
 2WMeEL7LyZPiXUzQ7j0xwePsRtsBwLGz+XBJQzWDUf4Kvl/3iKz2KifJMyiZCBkO9Z48poIjv
 HNpFKUEWKYVPh/NjkIy6IxLUgq8Qoj8Vce3bapdzPix2IMGbSmqnZHOrjNL2Yyve50uwVjrg+
 X0aKNNg4KU2TfQD8SqaruvyW0j3fgWahzNYEbeABjEZHdkvZz4QJPrr6LK5eBHtshFaBM1UP2
 jjMjFEY6nG8Py1eayMjJeZ7MtnIhjAwaUHOEFp/3al7TO4Toi9wv7WyVv/2TBslM6A+5too4O
 M+FZNn7MlV0AJ6g70kHtnBpSQ9By2y4YyocJSsK4XuhqmWt09BaG49REXkz3H1TzVjx2pI+DW
 H/ICYJvn7QW+rF+wZLGHKRwg/RJKyWw/GES9bZQLxAPQIbxB1/GliCf7HH8pl6VtTGtAZaw6v
 zcnz9FbQZ6oRl33EzlI558DKLnZrjwxTEltgRNPvatMFSdeGfJS1Zd36dp+Wiu/oEEzCq6YhX
 12eK/MxgTjAJ+bRkW6aVDl87kPjMCY02kISjAWOAnYBrQlb5jj6A++YQbxyy0jz+HuMRwpEgE
 Q0jczsP8ydDNCuIqRqhkHDY1BMBgHmqqzkHlG/fwp1l9EuvhrdxKHYMUpDld47mE4Z0VnwF8Z
 3+f4nkXFEBJS2B0PP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the efi=3Dnovamap kernel command line parameter.
Put the efi parameters into alphabetic order.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 .../admin-guide/kernel-parameters.txt          | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentati=
on/admin-guide/kernel-parameters.txt
index fb95fad81c79..b5beb1fe78cf 100644
=2D-- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1207,26 +1207,28 @@
 			Format: {"off" | "on" | "skip[mbr]"}

 	efi=3D		[EFI]
-			Format: { "old_map", "nochunk", "noruntime", "debug",
-				  "nosoftreserve", "disable_early_pci_dma",
-				  "no_disable_early_pci_dma" }
-			old_map [X86-64]: switch to the old ioremap-based EFI
-			runtime services mapping. [Needs CONFIG_X86_UV=3Dy]
+			Format: { "debug", "disable_early_pci_dma",
+				  "nochunk", "noruntime", "nosoftreserve",
+				  "novamap", "no_disable_early_pci_dma",
+				  "old_map" }
+			debug: enable misc debug output.
+			disable_early_pci_dma: disable the busmaster bit on all
+			PCI bridges while in the EFI boot stub.
 			nochunk: disable reading files in "chunks" in the EFI
 			boot stub, as chunking can cause problems with some
 			firmware implementations.
 			noruntime : disable EFI runtime services support
-			debug: enable misc debug output
 			nosoftreserve: The EFI_MEMORY_SP (Specific Purpose)
 			attribute may cause the kernel to reserve the
 			memory range for a memory mapping driver to
 			claim. Specify efi=3Dnosoftreserve to disable this
 			reservation and treat the memory by its base type
 			(i.e. EFI_CONVENTIONAL_MEMORY / "System RAM").
-			disable_early_pci_dma: Disable the busmaster bit on all
-			PCI bridges while in the EFI boot stub
+			novamap: do not call SetVirtualAddressMap().
 			no_disable_early_pci_dma: Leave the busmaster bit set
 			on all PCI bridges while in the EFI boot stub
+			old_map [X86-64]: switch to the old ioremap-based EFI
+			runtime services mapping. [Needs CONFIG_X86_UV=3Dy]

 	efi_no_storage_paranoia [EFI; X86]
 			Using this parameter you can use more than 50% of
=2D-
2.27.0

