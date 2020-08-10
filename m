Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035C2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0DE20678
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgHJVIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:08:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:46835 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgHJVIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:08:07 -0400
IronPort-SDR: yrQ1dshcTNEoIwib2Hy7w5xQCiDEZVROUsyS8nu3sb4z9J+8m3Z2RvYimLrUzjvhJfkY4p7hIb
 BbyHCDX1ukOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="238448642"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="gz'50?scan'50,208,50";a="238448642"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 13:47:04 -0700
IronPort-SDR: IKeqqZoA3IJa79i4awqPlFyQ2NNbIdCtIOCFf/vt91XZVKmgv/MfVdODcwmmjVLAhgr05VYYuF
 2Bzs61Mljogg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="gz'50?scan'50,208,50";a="334356429"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2020 13:47:02 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5EhC-0000CM-87; Mon, 10 Aug 2020 20:47:02 +0000
Date:   Tue, 11 Aug 2020 04:46:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: fs/notify/fanotify/fanotify_user.c:296:24: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202008110401.7p08JA2g%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc80c51fd4b23ec007e88d4c688f2cac1b8648e7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   8 weeks ago
config: m68k-randconfig-s031-20200811 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-141-g19506bc2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   fs/notify/fanotify/fanotify_user.c:135:63: sparse: sparse: restricted fmode_t degrades to integer
>> fs/notify/fanotify/fanotify_user.c:296:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got char [noderef] __user *[assigned] buf @@
   fs/notify/fanotify/fanotify_user.c:296:24: sparse:     expected void *to
   fs/notify/fanotify/fanotify_user.c:296:24: sparse:     got char [noderef] __user *[assigned] buf
   fs/notify/fanotify/fanotify_user.c:877:28: sparse: sparse: restricted fmode_t degrades to integer

vim +296 fs/notify/fanotify/fanotify_user.c

b2d879096ac7997 Eric Paris     2009-12-17  219  
44d705b0370b1d5 Amir Goldstein 2020-03-19  220  static int copy_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
44d705b0370b1d5 Amir Goldstein 2020-03-19  221  			     const char *name, size_t name_len,
44d705b0370b1d5 Amir Goldstein 2020-03-19  222  			     char __user *buf, size_t count)
5e469c830fdb5a1 Amir Goldstein 2019-01-10  223  {
5e469c830fdb5a1 Amir Goldstein 2019-01-10  224  	struct fanotify_event_info_fid info = { };
5e469c830fdb5a1 Amir Goldstein 2019-01-10  225  	struct file_handle handle = { };
afc894c784c84cb Jan Kara       2020-03-24  226  	unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *fh_buf;
cacfb956d46edc5 Amir Goldstein 2020-03-19  227  	size_t fh_len = fh ? fh->len : 0;
44d705b0370b1d5 Amir Goldstein 2020-03-19  228  	size_t info_len = fanotify_fid_info_len(fh_len, name_len);
44d705b0370b1d5 Amir Goldstein 2020-03-19  229  	size_t len = info_len;
5e469c830fdb5a1 Amir Goldstein 2019-01-10  230  
44d705b0370b1d5 Amir Goldstein 2020-03-19  231  	pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
44d705b0370b1d5 Amir Goldstein 2020-03-19  232  		 __func__, fh_len, name_len, info_len, count);
44d705b0370b1d5 Amir Goldstein 2020-03-19  233  
44d705b0370b1d5 Amir Goldstein 2020-03-19  234  	if (!fh_len || (name && !name_len))
5e469c830fdb5a1 Amir Goldstein 2019-01-10  235  		return 0;
5e469c830fdb5a1 Amir Goldstein 2019-01-10  236  
44d705b0370b1d5 Amir Goldstein 2020-03-19  237  	if (WARN_ON_ONCE(len < sizeof(info) || len > count))
5e469c830fdb5a1 Amir Goldstein 2019-01-10  238  		return -EFAULT;
5e469c830fdb5a1 Amir Goldstein 2019-01-10  239  
44d705b0370b1d5 Amir Goldstein 2020-03-19  240  	/*
44d705b0370b1d5 Amir Goldstein 2020-03-19  241  	 * Copy event info fid header followed by variable sized file handle
44d705b0370b1d5 Amir Goldstein 2020-03-19  242  	 * and optionally followed by variable sized filename.
44d705b0370b1d5 Amir Goldstein 2020-03-19  243  	 */
44d705b0370b1d5 Amir Goldstein 2020-03-19  244  	info.hdr.info_type = name_len ? FAN_EVENT_INFO_TYPE_DFID_NAME :
44d705b0370b1d5 Amir Goldstein 2020-03-19  245  					FAN_EVENT_INFO_TYPE_FID;
5e469c830fdb5a1 Amir Goldstein 2019-01-10  246  	info.hdr.len = len;
d766b553615ce67 Amir Goldstein 2020-03-19  247  	info.fsid = *fsid;
5e469c830fdb5a1 Amir Goldstein 2019-01-10  248  	if (copy_to_user(buf, &info, sizeof(info)))
5e469c830fdb5a1 Amir Goldstein 2019-01-10  249  		return -EFAULT;
5e469c830fdb5a1 Amir Goldstein 2019-01-10  250  
5e469c830fdb5a1 Amir Goldstein 2019-01-10  251  	buf += sizeof(info);
5e469c830fdb5a1 Amir Goldstein 2019-01-10  252  	len -= sizeof(info);
44d705b0370b1d5 Amir Goldstein 2020-03-19  253  	if (WARN_ON_ONCE(len < sizeof(handle)))
44d705b0370b1d5 Amir Goldstein 2020-03-19  254  		return -EFAULT;
44d705b0370b1d5 Amir Goldstein 2020-03-19  255  
afc894c784c84cb Jan Kara       2020-03-24  256  	handle.handle_type = fh->type;
5e469c830fdb5a1 Amir Goldstein 2019-01-10  257  	handle.handle_bytes = fh_len;
5e469c830fdb5a1 Amir Goldstein 2019-01-10  258  	if (copy_to_user(buf, &handle, sizeof(handle)))
5e469c830fdb5a1 Amir Goldstein 2019-01-10  259  		return -EFAULT;
5e469c830fdb5a1 Amir Goldstein 2019-01-10  260  
5e469c830fdb5a1 Amir Goldstein 2019-01-10  261  	buf += sizeof(handle);
5e469c830fdb5a1 Amir Goldstein 2019-01-10  262  	len -= sizeof(handle);
44d705b0370b1d5 Amir Goldstein 2020-03-19  263  	if (WARN_ON_ONCE(len < fh_len))
44d705b0370b1d5 Amir Goldstein 2020-03-19  264  		return -EFAULT;
44d705b0370b1d5 Amir Goldstein 2020-03-19  265  
b2d22b6bb33aac1 Jan Kara       2019-03-12  266  	/*
44d705b0370b1d5 Amir Goldstein 2020-03-19  267  	 * For an inline fh and inline file name, copy through stack to exclude
44d705b0370b1d5 Amir Goldstein 2020-03-19  268  	 * the copy from usercopy hardening protections.
b2d22b6bb33aac1 Jan Kara       2019-03-12  269  	 */
afc894c784c84cb Jan Kara       2020-03-24  270  	fh_buf = fanotify_fh_buf(fh);
b2d22b6bb33aac1 Jan Kara       2019-03-12  271  	if (fh_len <= FANOTIFY_INLINE_FH_LEN) {
afc894c784c84cb Jan Kara       2020-03-24  272  		memcpy(bounce, fh_buf, fh_len);
afc894c784c84cb Jan Kara       2020-03-24  273  		fh_buf = bounce;
b2d22b6bb33aac1 Jan Kara       2019-03-12  274  	}
afc894c784c84cb Jan Kara       2020-03-24  275  	if (copy_to_user(buf, fh_buf, fh_len))
5e469c830fdb5a1 Amir Goldstein 2019-01-10  276  		return -EFAULT;
5e469c830fdb5a1 Amir Goldstein 2019-01-10  277  
5e469c830fdb5a1 Amir Goldstein 2019-01-10  278  	buf += fh_len;
5e469c830fdb5a1 Amir Goldstein 2019-01-10  279  	len -= fh_len;
44d705b0370b1d5 Amir Goldstein 2020-03-19  280  
44d705b0370b1d5 Amir Goldstein 2020-03-19  281  	if (name_len) {
44d705b0370b1d5 Amir Goldstein 2020-03-19  282  		/* Copy the filename with terminating null */
44d705b0370b1d5 Amir Goldstein 2020-03-19  283  		name_len++;
44d705b0370b1d5 Amir Goldstein 2020-03-19  284  		if (WARN_ON_ONCE(len < name_len))
44d705b0370b1d5 Amir Goldstein 2020-03-19  285  			return -EFAULT;
44d705b0370b1d5 Amir Goldstein 2020-03-19  286  
44d705b0370b1d5 Amir Goldstein 2020-03-19  287  		if (copy_to_user(buf, name, name_len))
44d705b0370b1d5 Amir Goldstein 2020-03-19  288  			return -EFAULT;
44d705b0370b1d5 Amir Goldstein 2020-03-19  289  
44d705b0370b1d5 Amir Goldstein 2020-03-19  290  		buf += name_len;
44d705b0370b1d5 Amir Goldstein 2020-03-19  291  		len -= name_len;
44d705b0370b1d5 Amir Goldstein 2020-03-19  292  	}
44d705b0370b1d5 Amir Goldstein 2020-03-19  293  
44d705b0370b1d5 Amir Goldstein 2020-03-19  294  	/* Pad with 0's */
5e469c830fdb5a1 Amir Goldstein 2019-01-10  295  	WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);
5e469c830fdb5a1 Amir Goldstein 2019-01-10 @296  	if (len > 0 && clear_user(buf, len))
5e469c830fdb5a1 Amir Goldstein 2019-01-10  297  		return -EFAULT;
5e469c830fdb5a1 Amir Goldstein 2019-01-10  298  
44d705b0370b1d5 Amir Goldstein 2020-03-19  299  	return info_len;
5e469c830fdb5a1 Amir Goldstein 2019-01-10  300  }
5e469c830fdb5a1 Amir Goldstein 2019-01-10  301  

:::::: The code at line 296 was first introduced by commit
:::::: 5e469c830fdb5a1ebaa69b375b87f583326fd296 fanotify: copy event fid info to user

:::::: TO: Amir Goldstein <amir73il@gmail.com>
:::::: CC: Jan Kara <jack@suse.cz>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--fUYQa+Pmc3FrFX/N
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--fUYQa+Pmc3FrFX/N--
