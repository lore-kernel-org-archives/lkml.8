Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984AFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 607F62067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgFOHln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:41:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:30565 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728754AbgFOHlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:41:08 -0400
IronPort-SDR: VHEqlFDMPnKhKarbiPD7nLL96Ft8cW9jjUoScdGCFEOLETcC5yEyE+CU6xfOXGVYyeNonm8uNW
 WX9Sp52MXGRA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 00:40:35 -0700
IronPort-SDR: yZZEbOD+B/xwCslbXkuua8UzNUcMqcZDER1at8+q4hCwTE/+4S9fV8Ury1bkzoa0kaFvcs/owS
 lIYHXa7uF9mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="gz'50?scan'50,208,50";a="351277771"
Received: from lkp-server01.sh.intel.com (HELO d0919238dc75) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2020 00:40:30 -0700
Received: from kbuild by d0919238dc75 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jkjjK-00003e-60; Mon, 15 Jun 2020 07:40:30 +0000
Date:   Mon, 15 Jun 2020 15:39:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: drivers/video/fbdev/core/fbmem.c:803:39: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202006151548.kVt68f5u%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b3a9e3b9622ae10064826dccb4f7a52bd88c7407
commit: 80591e61a0f7e88deaada69844e4a31280c4a38f kbuild: tell sparse about the $ARCH
date:   7 months ago
config: nios2-randconfig-s032-20200615 (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-rc1-3-g55607964-dirty
        git checkout 80591e61a0f7e88deaada69844e4a31280c4a38f
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=nios2 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/core/fbmem.c:803:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *s @@     got unsigned char [noderef] [usertype] <asn:2> *[assigned] src @@
>> drivers/video/fbdev/core/fbmem.c:803:39: sparse:     expected void const *s
   drivers/video/fbdev/core/fbmem.c:803:39: sparse:     got unsigned char [noderef] [usertype] <asn:2> *[assigned] src
>> drivers/video/fbdev/core/fbmem.c:880:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *d @@     got unsigned char [noderef] [usertype] <asn:2> *[assigned] dst @@
>> drivers/video/fbdev/core/fbmem.c:880:32: sparse:     expected void *d
   drivers/video/fbdev/core/fbmem.c:880:32: sparse:     got unsigned char [noderef] [usertype] <asn:2> *[assigned] dst

vim +803 drivers/video/fbdev/core/fbmem.c

c47747fde931c0 drivers/video/fbmem.c Linus Torvalds     2011-05-11  756  
c47747fde931c0 drivers/video/fbmem.c Linus Torvalds     2011-05-11  757  static ssize_t
c47747fde931c0 drivers/video/fbmem.c Linus Torvalds     2011-05-11  758  fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
c47747fde931c0 drivers/video/fbmem.c Linus Torvalds     2011-05-11  759  {
c47747fde931c0 drivers/video/fbmem.c Linus Torvalds     2011-05-11  760  	unsigned long p = *ppos;
c47747fde931c0 drivers/video/fbmem.c Linus Torvalds     2011-05-11  761  	struct fb_info *info = file_fb_info(file);
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  762  	u8 *buffer, *dst;
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  763  	u8 __iomem *src;
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  764  	int c, cnt = 0, err = 0;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  765  	unsigned long total_size;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  766  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  767  	if (!info || ! info->screen_base)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  768  		return -ENODEV;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  769  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  770  	if (info->state != FBINFO_STATE_RUNNING)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  771  		return -EPERM;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  772  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  773  	if (info->fbops->fb_read)
3f9b0880e4a96b drivers/video/fbmem.c Antonino A. Daplas 2007-05-08  774  		return info->fbops->fb_read(info, buf, count, ppos);
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  775  	
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  776  	total_size = info->screen_size;
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  777  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  778  	if (total_size == 0)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  779  		total_size = info->fix.smem_len;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  780  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  781  	if (p >= total_size)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  782  		return 0;
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  783  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  784  	if (count >= total_size)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  785  		count = total_size;
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  786  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  787  	if (count + p > total_size)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  788  		count = total_size - p;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  789  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  790  	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  791  			 GFP_KERNEL);
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  792  	if (!buffer)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  793  		return -ENOMEM;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  794  
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  795  	src = (u8 __iomem *) (info->screen_base + p);
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  796  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  797  	if (info->fbops->fb_sync)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  798  		info->fbops->fb_sync(info);
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  799  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  800  	while (count) {
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  801  		c  = (count > PAGE_SIZE) ? PAGE_SIZE : count;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  802  		dst = buffer;
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27 @803  		fb_memcpy_fromfb(dst, src, c);
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  804  		dst += c;
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  805  		src += c;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  806  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  807  		if (copy_to_user(buf, buffer, c)) {
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  808  			err = -EFAULT;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  809  			break;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  810  		}
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  811  		*ppos += c;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  812  		buf += c;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  813  		cnt += c;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  814  		count -= c;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  815  	}
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  816  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  817  	kfree(buffer);
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  818  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  819  	return (err) ? err : cnt;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  820  }
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  821  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  822  static ssize_t
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  823  fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  824  {
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  825  	unsigned long p = *ppos;
c47747fde931c0 drivers/video/fbmem.c Linus Torvalds     2011-05-11  826  	struct fb_info *info = file_fb_info(file);
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  827  	u8 *buffer, *src;
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  828  	u8 __iomem *dst;
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  829  	int c, cnt = 0, err = 0;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  830  	unsigned long total_size;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  831  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  832  	if (!info || !info->screen_base)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  833  		return -ENODEV;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  834  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  835  	if (info->state != FBINFO_STATE_RUNNING)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  836  		return -EPERM;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  837  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  838  	if (info->fbops->fb_write)
3f9b0880e4a96b drivers/video/fbmem.c Antonino A. Daplas 2007-05-08  839  		return info->fbops->fb_write(info, buf, count, ppos);
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  840  	
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  841  	total_size = info->screen_size;
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  842  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  843  	if (total_size == 0)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  844  		total_size = info->fix.smem_len;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  845  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  846  	if (p > total_size)
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  847  		return -EFBIG;
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  848  
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  849  	if (count > total_size) {
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  850  		err = -EFBIG;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  851  		count = total_size;
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  852  	}
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  853  
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  854  	if (count + p > total_size) {
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  855  		if (!err)
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  856  			err = -ENOSPC;
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  857  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  858  		count = total_size - p;
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  859  	}
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  860  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  861  	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  862  			 GFP_KERNEL);
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  863  	if (!buffer)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  864  		return -ENOMEM;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  865  
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  866  	dst = (u8 __iomem *) (info->screen_base + p);
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  867  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  868  	if (info->fbops->fb_sync)
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  869  		info->fbops->fb_sync(info);
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  870  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  871  	while (count) {
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  872  		c = (count > PAGE_SIZE) ? PAGE_SIZE : count;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  873  		src = buffer;
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  874  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  875  		if (copy_from_user(src, buf, c)) {
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  876  			err = -EFAULT;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  877  			break;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  878  		}
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  879  
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27 @880  		fb_memcpy_tofb(dst, src, c);
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  881  		dst += c;
f11b478d461b71 drivers/video/fbmem.c James Hogan        2010-10-27  882  		src += c;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  883  		*ppos += c;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  884  		buf += c;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  885  		cnt += c;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  886  		count -= c;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  887  	}
0a484a3af905a2 drivers/video/fbmem.c Antonino A. Daplas 2006-01-09  888  
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  889  	kfree(buffer);
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  890  
6a2a88668e90cd drivers/video/fbmem.c Antonino A. Daplas 2006-04-18  891  	return (cnt) ? cnt : err;
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  892  }
^1da177e4c3f41 drivers/video/fbmem.c Linus Torvalds     2005-04-16  893  

:::::: The code at line 803 was first introduced by commit
:::::: f11b478d461b7113eb4603b3914aaf15b7788e87 fbmem: fix fb_read, fb_write unaligned accesses

:::::: TO: James Hogan <james@albanarts.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--/04w6evG8XlLl3ft
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICOMe514AAy5jb25maWcAnFxbk9u2kn7Pr2A5VVtJnXIiaS6e2a15AEFQREQQNADqMi8s
eUa2VRlLU5Imif/9NsCLABKUs3sqdWx1N26NRvfXDdA///RzgN5O+2/r0/Zp/fLyPfiy2W0O
69PmOfi8fdn8TxDxIOMqIBFVv4Fwut29/fP7brs/ToKb365/G70/PH0IZpvDbvMS4P3u8/bL
GzTf7nc//fwT/PczEL+9Qk+H/w5Mq/cvuof3X56egl+mGP8a3P929dsIJDHPYjotMS6pLIHz
8L0hwY9yToSkPHu4H12NRq1sirJpyxpZXSRIlkiycsoVP3dkMWiW0oz0WAskspKhVUjKIqMZ
VRSl9JFEliDPpBIFVlzIM5WKj+WCixlQzKKnRosvwXFzens9Ly4UfEaykmelZLnVGgYqSTYv
kZiWKWVUPVxNtOqaIVlOU1IqIlWwPQa7/Ul3fBZICIqI6PFrbsoxShslvXvnI5eosPUUFjSN
SolSZclHJEZFqsqES5UhRh7e/bLb7za/tgJI4KTMeCkXyFqbXMk5zXGPoP/EKgV6u4ycS7os
2ceCFMSzDiy4lCUjjItViZRCODn3WkiS0tDuDRVgsnY3ZmNgo4Lj26fj9+Np8+28MVOSEUGx
2cdc8NCyDJslE75wNz3iDNHMWl2OhCSa5e8hImExjaWZ6Gb3HOw/d6bUbYRhn2ZkTjIlG+NS
22+bw9G3DEXxDKyLwDzVeXzYk+RRWxHjma0hIOYwBo8o9qi7akWjlHR6crqg06QURMLIDEzJ
tc56fb3pWjsuCGG5gn4z34437DlPi0whsXKspWJeaIY5tGqUhvPid7U+/hmcYDrBGqZ2PK1P
x2D99LR/2522uy8dNUKDEmHTB82m9sihjLSRYALmCBL+M6mQnEmFlPRNUNKzTuFHe7YiKlGY
GnfTqu9fTNwsUOAikD6TyFYl8OwFwM+SLGHvfdqTlbDdvEPSK2u7rGfpjt6ekFn1F+vMzNpN
4tgmVz7Mcqkp144ohjNHY/UwGZ13l2ZqBt4pJh2Z8VWlCfn0dfP8BiEn+LxZn94Om6Mh1zP1
cFsPMxW8yKWtKnA3eOrd4Eq4lDgh0SWBnEbyEl9EDF3ix2DNj0RcEonInGJySQKMaNBSa5Ew
jy+PAY7LK6CDAbg9OA7+9gnBs5zDpmlHAWHTP1GjRxOHzHh+mZWMJcwEDjhGylV7Y9okRSsr
kqUzrR0TYUXkRlyBGPQmeSEwseKciMrpI7UiGBBCIEwcSvrIkENYPnb4vPP72gEbPAePCcii
jLnQXhj+YCjDxLa9rpiEv/gObBNImzXn8flHdczPvxm4GQrBUtgDySlRDE616QqlqX8QrayK
77Q1o19oGScoc4JIFeargGFRzbG2MYjrcxFE1bjwj1Aosjy3ND/h2FlKyHlqKUjSaYbSOLK9
HEzGJpiAaxNkAp7AgReUe6ZCeVmITrhA0ZzC5GsN+Q8JdB4iIah7zmvmTDdbMccvNbTSr/SW
bfSmD4Wic+LYiG8ztWGYSBT7zhbMkUSRDYZzPB5dNxG2TgLyzeHz/vBtvXvaBOSvzQ5CFQLP
i3WwAhxgu+J/2eI8vzmrdqYK7R3AYaFlpABqzxwzTVHo9ylpEfrsPeVhtz3skpiSJlj7e0uK
OAaoniMQBOUCxgaP5xWFABhTSEI6TrVWjZtAtPiLcmn5oRYjyoL1qcmCADpTHnHIaUIBDhSW
4nhLgHeU51woSIHyzrZaofQMH8ejUQdQTm5G/hTlsYTEbYgF/Yw8mwBYc3zO9sAFYgIzW5aP
ABe5ALjwMB73rOkc1fXs85f1SRtXsH/VSemxyUrZ5tv+8F0PphGUtSqjYn0ezdF5GP0zqv9X
tYs2f23BTE+HzabbJlIhpCVlnqzgVEaRsPTa8s/M0T+46fgcSVu5KiqVIefO6TZTyCCNDigN
trvj6fD21CzL6cPkYgJggUn6xt0hkoUOBKUscr3bPvBviS0bue6CgB3RucXtjBIDgv7REJjq
fDEcGqJhZ/yh3gC8Bvzm2TdcALZgYNuAI0pJlAbtsrcFNRsCKWzA3dm2HLauDDQyk44IdXoY
V9tXG2DP1ioLPOyfNsfj/hCcvr9WAL5/lhizAHYmNF6T/W2DczvNmPZ/AF7ynmGEe/h1tvMz
jmCRWVLXmpy+cwTZTC3ZVRs0VForkFvGMejWnIqbxnib1V9Yp5kNev5Lu/jnblEE4qNGPpEB
OzyTfUOaEZGRVCsJbHqq6xUmrF1cj79NtevVzH3i3e67muiLQY9PAwcZwMC/nq4rC51uzp3W
Cu7oz6kzrQ9PX7enzZNW9/vnzSs0gThqGUNjCgLJBEKksPY4QXNSOQywKkwSzi0YZui6MlZk
xvIjOFtTbYIdkatJSJU2j9Li1EU1SIMhAxBcEV01M8m+BUh5VKREauhRkjQ2WMUCGFOlE+Iy
hbCfyodJQ7+91sNp2GZX5kzgr2bSYYEnguBG4phiqs9PHDtmJkhsEMUQwtQ1GBt5tKWYKebz
95/WR9iVP6vw83rYf96+OOUELVRbjl3UBKJB/aq8Lj/YufSlTlvFpMWUZqYYh/HDuy//+c+7
Pnj4gVW06QnEe42ZieUvjcVKpvHhuLNVTnpsSHVoTjnyZ8K1VJFdkqhLkQP4uOpBCtxWLN2N
6klSf7Jas7WtQDZ6cTAN3yAAUikhlJyz3JIyHan8TYsM7BjOyIqFfADqK0FZIzfTGN0rFWqT
81giktnYTmOrWJWDKWjtgpU6lceaLwiKav4lnrftQlBFhhrbzLq1ORbkn83T22n96WVjbhEC
A+9Plh8KaRYzpQ+8lXOlseuYaiGJBc1Vjwwbg51sGdpGBcu9cHpoQjYWZOvd+svmm9dvxpBA
VQmgRQCXEhEDFZlT8c5TcEC5MkoxgfzareUjrOOcd9tnknk2vSkPMhgH1p1VCPJ6dH/bBhEC
1gSZvvF0MydRxSlBle/2l2fc6lNNfcyd4PcYFlbW93gV89T+bfyEXc5r3DbMN+9kw42wjgo+
WKgLzlX6pKPRrGrdKF3AISznJow4pWAi9LqHyq1TXd0iGU4YqpPC2iqGN/6s17aAnG1Of+8P
f4IT9mEs2NQZ8a2nyKhVm9C/wKCdDTK0iCK/w1IDbmQZC2bydX9NjiiIOCt/yyiH/EJP16cs
Wi25laZ5VTPCaODyCQRaBCc4xBFfCQOE8sy+8TK/yyjBeWcwTdZ4018BrAUEEn6+XjfN6SXm
VOi8lxVLHxYzEqUqsipWW1WuDI4un9GBImfVcK7oIDfmxSXeeVj/AHpbSpQM8yA4DTNprv3O
wG6fl2sTtUF2SArnDdntvojyYQM2EgItfiChubAvUgnuN1s9Ovz1nC94ltPK4CKklj9qHGjD
f3j39PZp+/TO7Z1FNx3Y0Frd/NY10/ltbev6sslfNzdCVf1WwvEpowHoo1d/e2lrby/u7a1n
c905MJrfDnM7NmuzJFW9VQOtvBU+3Rt2FkFUNnFRrXLSa11Z2oWpak+T66tuHT4GToIRNNof
5kOSclumix+NZ8QgLOCho6nv9EEK68hxUSZPVibngBjE8l5R7ywc01QN+Owwv8AE9xBhPOgU
JR5wmGLg8gnU7F804BwvPZ0MjBAKGk199xImrzRHWyInp69I3s7mKcrKu9Fk/NHLjgjOiD8M
pSmeDCwIpf69W05u/F2h3F8rzhM+NPwt5Ao58oM6SgjRa7q5HowAw7eIEfaVp6NM6ts0rh9w
PHyzr0kUQxofzr2d8Zxkc7mgCvvdzdyDC+x5mhrQoB9n+UDw0ivMpH/IRA4jmGqmEfEvRkuk
V4AxpfbDl6QyLP2Bub7b1DK5cC90fDI4RZAM+pyfiXHLMizkqnQvm8KPaQdBBqfNsX5v4Mwy
n6kp6VhQDVR7LTsMG5RaqkVMoGhoWQPGGvrtG8WwPjHkM+Jyhn2Jy4IKAn7cKRngeKoPw7hX
vmwZu83m+Ric9sGnDaxTJ23POmELwE8bAatsWlM09NelpsRcD1TF2fOICwpUv3eMZ9Rb8NH7
cW/h1ep3OacCUreuM7u/dDuOER24Vyd5UqbU72my2K/pXEJ4Sf2BzwC92M/zhcLGlUhVVc2t
2pTgML00dfYtRjTlczc82Vci0WH7V3O/18wWY+RihXPRcvtUtwh4P5sqqlpbQtLcm07AYVcs
d2t4Da1kukLnv51TKItQOvjYyAwaU8EWCJIE8wquObvx9vDt7/VhE7zs18+bg1UZWJi6F7Gu
e1qSyWMj/ULFvpCHvLYdxHp3cG6ls7p67c4G+ARgW9I0RNgf4c5N/AWv2ot0F9ceXwT60M8n
mtqKc61tymM2dyBkw8koI0HnAztp2GQuSGc3NV2/aKzbQrhjYH5+MKPFEORouBE2b/h8pYDm
CjQv6lczVs0Tgp/24Na7DTJ1KjvV75JOcI8m7fcGNW0x7pEYo7zfn112a/rDOOwLXtk5DUOl
TMCGjIHFtgFqVkwgR6oq+k5t2X/2qvujt2PwbA6zcxgZX6ou6ql7s1vYNS5wNbhz791sQCYt
BetfAK8FRWmHyPQTLx9DUhH7OUW47DGYipxytYqMscieT8rXh9NW6yJ4XR+OlR+zGiHxAQ6z
ULLbW3O3Zpie9WoZHvvbwtaZm7Ve2/OdWm9WZrIF/DVge/2KrXoqoQ7r3fHFPLsO0vX33vQ5
z6WjFDMm1WVIMJ8KQTWeTiD2u+Ds9/hlffwaPH3dvgbPrWu3Vx5Tt8s/CMDzzuNZTYcz131T
W7fXONV369ewM67fEg9oVQuE4KVXijRPjnsdpBbfD1lrwSnhjCixGhhLH74QAfZd0Egl5dhd
SYc7uci97muBjj20Ti9c5R6hTAG8WiqPYhmE9ahPhwiI+tRCUffMlGAEPWvl/sTQHI9Qkm7M
bR6GDptTVXxfv75q+FoTDdAzUusnfZ3csTmu0c+yqSt3bTpZSdY3hJpc3w8OrqER4/GAETQC
05zy5oGH20OK9KNCrxp+tMzq4erm5fP7p/3utN7uAPNCn7V39Z/ACFLbGFKSpDuRllFf0EBE
pLG/quaKd8quthXjJJ9czSY3t67OpVSTm47xyNRjPnnSUY3duYqqFmca/C4Vh9S9QvP2XUfN
JcJcUWrueHJXQ9Ht8c/3fPcea832cKm9ZI6nV1aShpPqw46SPYyv+1RlrnCaB8Q/3CV7pAwg
Z+fC3ZznjGhOV0s1ud6xavsG960RrkHNUPSppSoP4u1gstQOejq8QUaKYAyOVGeVrHOnMyBS
SjY0KV0Prtc/0Edovu6oItL6798h/q1fXjYvgZYJPlfOBPbgsAdqd3dNP2xpV4Bbsj69HrI+
u/o2vhmTbY9Pnk71/0nKPB1EVM54hhPa03KHXcXCS1XsS40iDeLt5NYnHIaqZzn2+cxpo3yz
1jSHboP/qv6cBDmk8t+qmzGv2zFirgY+0izmbZBvT8qPO3bXYSbmhY2aW4QdwAGEcpGWKhH6
gxfI1TpewgiEJKw/qZp0tKa5MUAfNggxtMQ0LUh34GQFmZeTKUTKsjUe23/X93tKg06HqO+P
lSDEIRIk0pWfNePhHw4hWmWIUWfU1jxsmpNcwO/qeu/8GxoQMdco0L7erhi6vOjQdP7vvBgF
GOk+26sJJVre3X24d25NGhZ462tf/l2zM42IcVszmzMSyLfX1/3hZD8ddujtibXSlyanI5nk
QoIJyKt0PppYHgdFN5ObZRnl3LnmsMg60/PM1JZw8j5Igtmq84oCy/uribweWRgPMrOUy0Lo
d4qik4OiPJL3d6MJSu2vC2U6uR+NrrqUifP6tlmqAt7Nje89bSMRJuMPH0ZW4lvTzeD3o6Xd
a8Lw7dXNxJe6y/HtnQVTtdnCYsCB51dlRbOGcAL8Uj98hmwtionzhiOf5yjzRjI8qe2sel9C
cg1Hj5ZdNLo1nBKpib/YfubfeEapuSmZIux8bFYzGFre3n240PL+Ci8thNRSl8vrW09/kBGU
d/dJTqS/PlmLETIeja69uLKjier7wM0/62NAzfPgb+Y5/fHr+gBQ5aTTRC0XvAB0CZ7hxGxf
9V9tDSqdJXjH+n/027dOfRD1qblgnkakKrJY1SZIUZHOX/L+i2i6OwEyAG8IseaweTFfL59t
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
sTX+B33+v6OWRwEA

--/04w6evG8XlLl3ft--
