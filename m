Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D58C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C094F20707
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593092552;
	bh=463aQghOu/rNntyoRvD8Pz814OFMFs7IFXr1zdsbRAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Vv46TFv0+bx0bbw/xxK+UR+R0udbALDmdm8vLKjUPOaAapM77ThaS1u/TonHYFzzl
	 Xw0YZhKCOvFWYa/mQc+vzBoaaPG4jZ7ytxCQwbPa3buj8YJnbkEyvcUzUe2HhNBEME
	 4AkcpmJGCkznjLwNhSCBgkqgNZ7gkUBfQR5aR6Uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405093AbgFYNma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:42:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404923AbgFYNm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:42:29 -0400
Received: from coco.lan (unknown [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1987020707;
        Thu, 25 Jun 2020 13:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593092549;
        bh=463aQghOu/rNntyoRvD8Pz814OFMFs7IFXr1zdsbRAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CkHqsHgDyNzvfEsJeSBeRZ+t2148K3lmzocPkYlPEmtQ0allJP7306VYPTBjSEEQV
         KDka4UyLmwmD7JB5lbKWVE5N5rZsgzfwMt8uvBH11lI9uvmdquZe0+Go9u5WYx8yhZ
         wDq5uuxhilVca/+Apxy07UTQbZkiRmVbZBzzd3nU=
Date:   Thu, 25 Jun 2020 15:42:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Search function in xconfig is partially broken after recent
 changes
Message-ID: <20200625154226.25692cd1@coco.lan>
In-Reply-To: <20200625125906.6b7688eb@coco.lan>
References: <a98b0f0ebe0c23615a76f1d23f25fd0c84835e6b.camel@redhat.com>
        <20200625125906.6b7688eb@coco.lan>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Jun 2020 12:59:15 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Hi Maxim,
> 
> Em Thu, 25 Jun 2020 12:25:10 +0300
> Maxim Levitsky <mlevitsk@redhat.com> escreveu:
> 
> > Hi!
> > 
> > I noticed that on recent kernels the search function in xconfig is partially broken.
> > This means that when you select a found entry, it is not selected in the main window,
> > something that I often do to find some entry near the area I would like to modify,
> > and then use main window to navigate/explore that area.
> > 
> > Reverting these commits helps restore the original behavier:
> > 
> > b311142fcfd37b58dfec72e040ed04949eb1ac86 - kconfig: qconf: fix support for the split view mode
> > cce1faba82645fee899ccef5b7d3050fed3a3d10 - kconfig: qconf: fix the content of the main widget
> > 
> > I have Qt5 5.13.2 from fedora 31 (5.13.2-1.fc31)
> > 
> > Could you explain what these commits are supposed to fix?
> > I mostly use the split view mode too and it does appear to work for me with these commits reverted as well.

Btw, I did a quick hack that makes it partially work: it updates the
main window, but if you seek for two items at the same window, it doesn't
do the right thing. It is also not updating the split window yet.

I'll try to polish and fix it if I have more time.

Thanks,
Mauro


diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index c0ac8f7b5f1a..700731bf04b0 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1645,12 +1645,15 @@ void ConfigMainWindow::setMenuLink(struct menu *menu)
 			return;
 		list->setRootMenu(parent);
 		break;
+	case menuMode:
 	case symbolMode:
-		if (menu->flags & MENU_ROOT) {
+		if (!(menu->flags & MENU_ROOT)) {
+printf("Set root!\n");
 			configList->setRootMenu(menu);
 			configList->clearSelection();
 			list = menuList;
 		} else {
+printf("config list!\n");
 			list = configList;
 			parent = menu_get_parent_menu(menu->parent);
 			if (!parent)
@@ -1659,6 +1662,7 @@ void ConfigMainWindow::setMenuLink(struct menu *menu)
 			if (item) {
 				item->setSelected(true);
 				menuList->scrollToItem(item);
+				menuList->setFocus();
 			}
 			list->setRootMenu(parent);
 		}
@@ -1671,6 +1675,7 @@ void ConfigMainWindow::setMenuLink(struct menu *menu)
 	}
 
 	if (list) {
+printf("findConfigItem on list mode\n");
 		item = list->findConfigItem(menu);
 		if (item) {
 			item->setSelected(true);

