Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C57C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9FA204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389327AbgEMQL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgEMQL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:11:27 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF32C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:11:26 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYtyT-007b0k-8h; Wed, 13 May 2020 16:11:13 +0000
Date:   Wed, 13 May 2020 17:11:13 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Patrick Donnelly <batrick@batbytes.com>
Cc:     open list <linux-kernel@vger.kernel.org>
Subject: Re: file system permissions regression affecting root
Message-ID: <20200513161113.GU23230@ZenIV.linux.org.uk>
References: <CACh33FpkBrHpTNfZN6EiyaVPVb6bvJqHO8dJkiHzWPOF0+pKAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACh33FpkBrHpTNfZN6EiyaVPVb6bvJqHO8dJkiHzWPOF0+pKAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 08:00:28AM -0700, Patrick Donnelly wrote:
> In newer kernels (at least 5.6), it appears root is not able to write
> to files owned by other users in a sticky directory:

Yes.  Controlled by /proc/sys/fs/protected_regular, which systemd crowd
has decided to enable in commit 2732587540035227fe59e4b64b60127352611b35
Author: Lucas Werkmeister <mail@lucaswerkmeister.de>
Date:   Wed Jan 16 00:16:10 2019 +0100

    Enable regular file and FIFO protection
    
    These sysctls were added in Linux 4.19 (torvalds/linux@30aba6656f), and
    we should enable them just like we enable the older hardlink/symlink
    protection since v199. Implements #11414.

in their tree.  The relevant part is this:
diff --git a/sysctl.d/50-default.conf b/sysctl.d/50-default.conf
index b0645f33e7..27084f6242 100644
--- a/sysctl.d/50-default.conf
+++ b/sysctl.d/50-default.conf
@@ -36,3 +36,7 @@ net.core.default_qdisc = fq_codel
 # Enable hard and soft link protection
 fs.protected_hardlinks = 1
 fs.protected_symlinks = 1
+
+# Enable regular file and FIFO protection
+fs.protected_regular = 1
+fs.protected_fifos = 1

so if you want the normal behaviour (and I certainly agree that the value
of that "protection" is not terribly high - I don't enable it on any of
my boxen and I don't use systemd, so they can't make those decisions for
me), I would suggest going into /etc/sysctl.d/ and telling the damn
thing _not_ to enable that.

From the same commit:
+        * The fs.protected_regular and fs.protected_fifos sysctls, which were
+          added in Linux 4.19 to make some data spoofing attacks harder, are
+          now enabled by default. While this will hopefully improve the
+          security of most installations, it is technically a backwards
+          incompatible change; to disable these sysctls again, place the
+          following lines in /etc/sysctl.d/60-protected.conf or a similar file:
+
+              fs.protected_regular = 0
+              fs.protected_fifos = 0
+
+          Note that the similar hardlink and symlink protection has been
+          enabled since v199, and may be disabled likewise.

