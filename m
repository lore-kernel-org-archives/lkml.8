Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66905C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E453206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TaSYsSNy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="RAz87N8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgFQQPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:15:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58002 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgFQQPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:15:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23A3C78CFC;
        Wed, 17 Jun 2020 12:15:08 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=+7T4qdnSw0gxbynV88wNU0Ova50=; b=TaSYsS
        NyprQZxRd8qnUwsyXVXQrpeU44aK7HkLOq1YWUyzrfcsJ5lFxKYyl3PqxFQyTKrJ
        JRAxoEkz8GO/oZTGhk+oeMSaPuFBL9gxia19sd/UligNF1k3eWQcPOn3zXwz7Ri8
        CvvuTMUQ89ZeDkbftS2mO3PGvGTzw2rGEoQKg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3B0678CFA;
        Wed, 17 Jun 2020 12:15:07 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=B/BxgtQ/Smh+TWwKVGcdjBht/0xBiGGKZZd4NIBjG28=; b=RAz87N8MZLYFu5fn8xW4cgCW4C6GkFpRYLERZAmCoCTZjoXjOhfbuwJTAEBuZ8jfghK3EqKSpJqMkXGQQkiwdsNQULw+T8Xsb+0pUYf613WVDDkeWxQvr3/ikWKa7rqsh9hMH9NcEfQIurmSh4JfCMp95/RC9athjEeumOjjRGk=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D239878CF9;
        Wed, 17 Jun 2020 12:15:06 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id B3AA22DA0E05;
        Wed, 17 Jun 2020 12:15:05 -0400 (EDT)
Date:   Wed, 17 Jun 2020 12:15:05 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     kernel test robot <lkp@intel.com>
cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: drivers/tty/vt/vt.c:1210:22: warning: comparison is always false
 due to limited range of data type
In-Reply-To: <20200615062409.GJ12456@shao2-debian>
Message-ID: <nycvar.YSQ.7.77.849.2006171210150.1785@knanqh.ubzr>
References: <20200615062409.GJ12456@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: B5808BF0-B0B5-11EA-AD5F-C28CBED8090B-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know what to do with this.  IMHO the warning is useless in this 
particular case. It happens only on a few targets and depends on the 
kernel config, etc.

If the condition is always false in some cases then so be it. The 
compiler can optimize the unneeded code away I'm sure.

On Mon, 15 Jun 2020, kernel test robot wrote:

> Hi Nicolas,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f82e7b57b5fc48199e2f26ffafe2f96f7338ad3d
> commit: 2717769e204e83e65b8819c5e2ef3e5b6639b270 vt: don't hardcode the mem allocation upper bound
> date:   7 weeks ago
> :::::: branch date: 2 hours ago
> :::::: commit date: 7 weeks ago
> config: ia64-randconfig-r024-20200614 (attached as .config)
> compiler: ia64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 2717769e204e83e65b8819c5e2ef3e5b6639b270
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> drivers/tty/vt/vt.c: In function 'vc_do_resize':
> >> drivers/tty/vt/vt.c:1210:22: warning: comparison is always false due to limited range of data type [-Wtype-limits]
> 1210 |  if (new_screen_size > KMALLOC_MAX_SIZE)
> |                      ^
> 
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2717769e204e83e65b8819c5e2ef3e5b6639b270
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git remote update linus
> git checkout 2717769e204e83e65b8819c5e2ef3e5b6639b270
> vim +1210 drivers/tty/vt/vt.c
> 
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1163  
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1164  /**
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1165   *	vc_do_resize	-	resizing method for the tty
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1166   *	@tty: tty being resized
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1167   *	@real_tty: real tty (different to tty if a pty/tty pair)
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1168   *	@vc: virtual console private data
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1169   *	@cols: columns
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1170   *	@lines: lines
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1171   *
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1172   *	Resize a virtual console, clipping according to the actual constraints.
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1173   *	If the caller passes a tty structure then update the termios winsize
> 3ad2f3fbb96142 drivers/char/vt.c   Daniel Mack         2010-02-03  1174   *	information and perform any necessary signal handling.
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1175   *
> 6a1c0680cf3ba9 drivers/tty/vt/vt.c Peter Hurley        2013-06-15  1176   *	Caller must hold the console semaphore. Takes the termios rwsem and
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1177   *	ctrl_lock of the tty IFF a tty is passed.
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1178   */
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1179  
> fc6f6238226e6d drivers/char/vt.c   Alan Cox            2009-01-02  1180  static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
> fc6f6238226e6d drivers/char/vt.c   Alan Cox            2009-01-02  1181  				unsigned int cols, unsigned int lines)
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1182  {
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1183  	unsigned long old_origin, new_origin, new_scr_end, rlth, rrem, err = 0;
> 9e0ba741aabdf1 drivers/char/vt.c   qiaochong           2010-08-09  1184  	unsigned long end;
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1185  	unsigned int old_rows, old_row_size, first_copied_row;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1186  	unsigned int new_cols, new_rows, new_row_size, new_screen_size;
> 9e0ba741aabdf1 drivers/char/vt.c   qiaochong           2010-08-09  1187  	unsigned int user;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1188  	unsigned short *newscreen;
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1189  	struct uni_screen *new_uniscr = NULL;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1190  
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1191  	WARN_CONSOLE_UNLOCKED();
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1192  
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1193  	if (!vc)
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1194  		return -ENXIO;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1195  
> e400b6ec4ede4d drivers/char/vt.c   Antonino A. Daplas  2007-10-16  1196  	user = vc->vc_resize_user;
> e400b6ec4ede4d drivers/char/vt.c   Antonino A. Daplas  2007-10-16  1197  	vc->vc_resize_user = 0;
> e400b6ec4ede4d drivers/char/vt.c   Antonino A. Daplas  2007-10-16  1198  
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1199  	if (cols > VC_RESIZE_MAXCOL || lines > VC_RESIZE_MAXROW)
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1200  		return -EINVAL;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1201  
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1202  	new_cols = (cols ? cols : vc->vc_cols);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1203  	new_rows = (lines ? lines : vc->vc_rows);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1204  	new_row_size = new_cols << 1;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1205  	new_screen_size = new_row_size * new_rows;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1206  
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1207  	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1208  		return 0;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1209  
> 2717769e204e83 drivers/tty/vt/vt.c Nicolas Pitre       2020-03-28 @1210  	if (new_screen_size > KMALLOC_MAX_SIZE)
> 32b2921e6a7461 drivers/tty/vt/vt.c Dmitry Vyukov       2016-10-14  1211  		return -EINVAL;
> 21eff69aaaa0e7 drivers/tty/vt/vt.c Alexander Potapenko 2018-06-14  1212  	newscreen = kzalloc(new_screen_size, GFP_USER);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1213  	if (!newscreen)
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1214  		return -ENOMEM;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1215  
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1216  	if (get_vc_uniscr(vc)) {
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1217  		new_uniscr = vc_uniscr_alloc(new_cols, new_rows);
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1218  		if (!new_uniscr) {
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1219  			kfree(newscreen);
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1220  			return -ENOMEM;
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1221  		}
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1222  	}
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1223  
> dce05aa6eec977 drivers/tty/vt/vt.c Jiri Slaby          2020-02-19  1224  	if (vc_is_sel(vc))
> 009e39ae44f419 drivers/tty/vt/vt.c Scot Doyle          2016-10-13  1225  		clear_selection();
> 009e39ae44f419 drivers/tty/vt/vt.c Scot Doyle          2016-10-13  1226  
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1227  	old_rows = vc->vc_rows;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1228  	old_row_size = vc->vc_size_row;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1229  
> e400b6ec4ede4d drivers/char/vt.c   Antonino A. Daplas  2007-10-16  1230  	err = resize_screen(vc, new_cols, new_rows, user);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1231  	if (err) {
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1232  		kfree(newscreen);
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1233  		kfree(new_uniscr);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1234  		return err;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1235  	}
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1236  
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1237  	vc->vc_rows = new_rows;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1238  	vc->vc_cols = new_cols;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1239  	vc->vc_size_row = new_row_size;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1240  	vc->vc_screenbuf_size = new_screen_size;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1241  
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1242  	rlth = min(old_row_size, new_row_size);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1243  	rrem = new_row_size - rlth;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1244  	old_origin = vc->vc_origin;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1245  	new_origin = (long) newscreen;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1246  	new_scr_end = new_origin + new_screen_size;
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1247  
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1248  	if (vc->vc_y > new_rows) {
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1249  		if (old_rows - vc->vc_y < new_rows) {
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1250  			/*
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1251  			 * Cursor near the bottom, copy contents from the
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1252  			 * bottom of buffer
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1253  			 */
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1254  			first_copied_row = (old_rows - new_rows);
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1255  		} else {
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1256  			/*
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1257  			 * Cursor is in no man's land, copy 1/2 screenful
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1258  			 * from the top and bottom of cursor position
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1259  			 */
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1260  			first_copied_row = (vc->vc_y - new_rows/2);
> 9fc2b2d0cf7430 drivers/char/vt.c   Francisco Jerez     2010-08-22  1261  		}
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1262  		old_origin += first_copied_row * old_row_size;
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1263  	} else
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1264  		first_copied_row = 0;
> 9fc2b2d0cf7430 drivers/char/vt.c   Francisco Jerez     2010-08-22  1265  	end = old_origin + old_row_size * min(old_rows, new_rows);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1266  
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1267  	vc_uniscr_copy_area(new_uniscr, new_cols, new_rows,
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1268  			    get_vc_uniscr(vc), rlth/2, first_copied_row,
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1269  			    min(old_rows, new_rows));
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1270  	vc_uniscr_set(vc, new_uniscr);
> d8ae7242718738 drivers/tty/vt/vt.c Nicolas Pitre       2018-06-26  1271  
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1272  	update_attr(vc);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1273  
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1274  	while (old_origin < end) {
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1275  		scr_memcpyw((unsigned short *) new_origin,
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1276  			    (unsigned short *) old_origin, rlth);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1277  		if (rrem)
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1278  			scr_memsetw((void *)(new_origin + rlth),
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1279  				    vc->vc_video_erase_char, rrem);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1280  		old_origin += old_row_size;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1281  		new_origin += new_row_size;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1282  	}
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1283  	if (new_scr_end > new_origin)
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1284  		scr_memsetw((void *)new_origin, vc->vc_video_erase_char,
> 3b41dc1a3c7839 drivers/char/vt.c   Antonino A. Daplas  2005-09-09  1285  			    new_scr_end - new_origin);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1286  	kfree(vc->vc_screenbuf);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1287  	vc->vc_screenbuf = newscreen;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1288  	vc->vc_screenbuf_size = new_screen_size;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1289  	set_origin(vc);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1290  
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1291  	/* do part of a reset_terminal() */
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1292  	vc->vc_top = 0;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1293  	vc->vc_bottom = vc->vc_rows;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1294  	gotoxy(vc, vc->vc_x, vc->vc_y);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1295  	save_cur(vc);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1296  
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1297  	if (tty) {
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1298  		/* Rewrite the requested winsize data with the actual
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1299  		   resulting sizes */
> 8c9a9dd0fa3a26 drivers/char/vt.c   Alan Cox            2008-08-15  1300  		struct winsize ws;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1301  		memset(&ws, 0, sizeof(ws));
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1302  		ws.ws_row = vc->vc_rows;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1303  		ws.ws_col = vc->vc_cols;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1304  		ws.ws_ypixel = vc->vc_scan_lines;
> fc6f6238226e6d drivers/char/vt.c   Alan Cox            2009-01-02  1305  		tty_do_resize(tty, &ws);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1306  	}
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1307  
> 6ca8dfd78187d8 drivers/tty/vt/vt.c Jiri Slaby          2016-06-23  1308  	if (con_is_visible(vc))
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1309  		update_screen(vc);
> 8b92e87d39bfd0 drivers/char/vt.c   Alan Cox            2009-09-19  1310  	vt_event_post(VT_EVENT_RESIZE, vc->vc_num, vc->vc_num);
> 0c9b1965faddad drivers/tty/vt/vt.c Nicolas Pitre       2019-01-08  1311  	notify_update(vc);
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1312  	return err;
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1313  }
> ^1da177e4c3f41 drivers/char/vt.c   Linus Torvalds      2005-04-16  1314  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
