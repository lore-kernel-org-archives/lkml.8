Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFD3C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 05:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93740206F1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 05:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgEaFYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 01:24:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:40512 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgEaFYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 01:24:15 -0400
IronPort-SDR: SIuaDqBLUXgiRPGbXVfkscsRTP0RAhoU3s7Ee5hsb9RSRLhChA2pDElOWOIzqG5v3DLQiyLzO3
 z8RkM8/aRuCA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2020 22:24:14 -0700
IronPort-SDR: TK6VXQgMAwrRudfIl3TEsRKADKkYSuLLf9F1F2AUIO0k7s3pEtDPeAh2RFCQtlGK33Yia17Kk+
 xygMn5lv9TPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,455,1583222400"; 
   d="scan'208";a="267981563"
Received: from lkp-server01.sh.intel.com (HELO 9f9df8056aac) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 May 2020 22:24:12 -0700
Received: from kbuild by 9f9df8056aac with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfGSB-0000tm-C4; Sun, 31 May 2020 05:24:11 +0000
Date:   Sun, 31 May 2020 13:24:05 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Namjae, Jeon," <namjae.jeon@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: fs/exfat/nls.c:531:22: warning: Variable 'p_uniname->name_len' is
 reassigned a value before the old one has been used. [redundantAssignment]
Message-ID: <202005311303.tM8DT7hg%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ffeb595d84811dde16a28b33d8a7cf26d51d51b3
commit: b9d1e2e6265f5dc25e9f5dbfbde3e53d8a4958ac exfat: add Kconfig and Makefile
date:   3 months ago
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> fs/exfat/nls.c:531:22: warning: Variable 'p_uniname->name_len' is reassigned a value before the old one has been used. [redundantAssignment]
    p_uniname->name_len = unilen;
                        ^
   fs/exfat/nls.c:519:22: note: Variable 'p_uniname->name_len' is reassigned a value before the old one has been used.
    p_uniname->name_len = unilen & 0xFF;
                        ^
   fs/exfat/nls.c:531:22: note: Variable 'p_uniname->name_len' is reassigned a value before the old one has been used.
    p_uniname->name_len = unilen;
                        ^

vim +531 fs/exfat/nls.c

370e812b3ec190 Namjae Jeon 2020-03-02  492  
370e812b3ec190 Namjae Jeon 2020-03-02  493  static int exfat_utf8_to_utf16(struct super_block *sb,
370e812b3ec190 Namjae Jeon 2020-03-02  494  		const unsigned char *p_cstring, const int len,
370e812b3ec190 Namjae Jeon 2020-03-02  495  		struct exfat_uni_name *p_uniname, int *p_lossy)
370e812b3ec190 Namjae Jeon 2020-03-02  496  {
370e812b3ec190 Namjae Jeon 2020-03-02  497  	int i, unilen, lossy = NLS_NAME_NO_LOSSY;
370e812b3ec190 Namjae Jeon 2020-03-02  498  	unsigned short upname[MAX_NAME_LENGTH + 1];
370e812b3ec190 Namjae Jeon 2020-03-02  499  	unsigned short *uniname = p_uniname->name;
370e812b3ec190 Namjae Jeon 2020-03-02  500  
370e812b3ec190 Namjae Jeon 2020-03-02  501  	WARN_ON(!len);
370e812b3ec190 Namjae Jeon 2020-03-02  502  
370e812b3ec190 Namjae Jeon 2020-03-02  503  	unilen = utf8s_to_utf16s(p_cstring, len, UTF16_HOST_ENDIAN,
370e812b3ec190 Namjae Jeon 2020-03-02  504  			(wchar_t *)uniname, MAX_NAME_LENGTH + 2);
370e812b3ec190 Namjae Jeon 2020-03-02  505  	if (unilen < 0) {
370e812b3ec190 Namjae Jeon 2020-03-02  506  		exfat_msg(sb, KERN_ERR,
370e812b3ec190 Namjae Jeon 2020-03-02  507  			"failed to %s (err : %d) nls len : %d",
370e812b3ec190 Namjae Jeon 2020-03-02  508  			__func__, unilen, len);
370e812b3ec190 Namjae Jeon 2020-03-02  509  		return unilen;
370e812b3ec190 Namjae Jeon 2020-03-02  510  	}
370e812b3ec190 Namjae Jeon 2020-03-02  511  
370e812b3ec190 Namjae Jeon 2020-03-02  512  	if (unilen > MAX_NAME_LENGTH) {
370e812b3ec190 Namjae Jeon 2020-03-02  513  		exfat_msg(sb, KERN_ERR,
370e812b3ec190 Namjae Jeon 2020-03-02  514  			"failed to %s (estr:ENAMETOOLONG) nls len : %d, unilen : %d > %d",
370e812b3ec190 Namjae Jeon 2020-03-02  515  			__func__, len, unilen, MAX_NAME_LENGTH);
370e812b3ec190 Namjae Jeon 2020-03-02  516  		return -ENAMETOOLONG;
370e812b3ec190 Namjae Jeon 2020-03-02  517  	}
370e812b3ec190 Namjae Jeon 2020-03-02  518  
370e812b3ec190 Namjae Jeon 2020-03-02  519  	p_uniname->name_len = unilen & 0xFF;
370e812b3ec190 Namjae Jeon 2020-03-02  520  
370e812b3ec190 Namjae Jeon 2020-03-02  521  	for (i = 0; i < unilen; i++) {
370e812b3ec190 Namjae Jeon 2020-03-02  522  		if (*uniname < 0x0020 ||
370e812b3ec190 Namjae Jeon 2020-03-02  523  		    exfat_wstrchr(bad_uni_chars, *uniname))
370e812b3ec190 Namjae Jeon 2020-03-02  524  			lossy |= NLS_NAME_LOSSY;
370e812b3ec190 Namjae Jeon 2020-03-02  525  
370e812b3ec190 Namjae Jeon 2020-03-02  526  		upname[i] = exfat_toupper(sb, *uniname);
370e812b3ec190 Namjae Jeon 2020-03-02  527  		uniname++;
370e812b3ec190 Namjae Jeon 2020-03-02  528  	}
370e812b3ec190 Namjae Jeon 2020-03-02  529  
370e812b3ec190 Namjae Jeon 2020-03-02  530  	*uniname = '\0';
370e812b3ec190 Namjae Jeon 2020-03-02 @531  	p_uniname->name_len = unilen;
370e812b3ec190 Namjae Jeon 2020-03-02  532  	p_uniname->name_hash = exfat_calc_chksum_2byte(upname, unilen << 1, 0,
370e812b3ec190 Namjae Jeon 2020-03-02  533  			CS_DEFAULT);
370e812b3ec190 Namjae Jeon 2020-03-02  534  
370e812b3ec190 Namjae Jeon 2020-03-02  535  	if (p_lossy)
370e812b3ec190 Namjae Jeon 2020-03-02  536  		*p_lossy = lossy;
370e812b3ec190 Namjae Jeon 2020-03-02  537  	return unilen;
370e812b3ec190 Namjae Jeon 2020-03-02  538  }
370e812b3ec190 Namjae Jeon 2020-03-02  539  

:::::: The code at line 531 was first introduced by commit
:::::: 370e812b3ec190fa492c9fd5a80c38b086d105c0 exfat: add nls operations

:::::: TO: Namjae Jeon <namjae.jeon@samsung.com>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
