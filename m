Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316A8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B7E235FF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hEvH4qvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgHEQSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:18:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54866 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgHEQOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:14:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075Dg4nl052289;
        Wed, 5 Aug 2020 13:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=RMqrIU6pEOHrTAzyAxKbs76zBmc+tuV1JrAkmGwm880=;
 b=hEvH4qvZjPHu5hSZiQXb1nctUACF9mQajmWHFdozuJFbBo1tk5Q2Y90bmXQheI7tTAA6
 9rh04Y0tVq7zA16je5BZmShI6n7hRmfy7h9/Ipru34+bzvxsuBtk5KBZLfa49Y2OQ2F8
 kKPtNM6GffAzBmWKa5Ekn9YWi6jZKuWW4w0xEea/iQ2nf5AUt+mX77gwNAfJfcYLkck+
 ONxvE1zxG7krnhG8C0nWxufv11RXzkUpIo0sru6G5xqjMMjQpyMfb8GEUd1yfhu0xLmr
 2Ftv1W56uzIwzrvV9obcqXDkc6j0tD1vVh1Vp4D5cLGKW1/wU9wJHa+fmqblGF/1M1fA sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 32qnd42dc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 13:44:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075DgtHC133802;
        Wed, 5 Aug 2020 13:44:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32pdntc5h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 13:44:30 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 075DiSa8029091;
        Wed, 5 Aug 2020 13:44:28 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Aug 2020 06:44:27 -0700
Date:   Wed, 5 Aug 2020 16:44:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Konrad Dybcio <konradybcio@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [kbuild] drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c:120:2:
 warning: Local variable ret shadows outer variable
Message-ID: <20200805134421.GP5493@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: B2LG3KDNHDMBDGZLGAGLKGWOTGEMYTZF
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2324d50d051ec0f14a548e78554fb02513d6dcef
commit: 02ed76b6da0710a9d24f36a4a9800a68d7edb9a7 drivers: drm: panel: Add ASUS TM5P5 NT35596 panel driver

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

cppcheck warnings: (new ones prefixed by >>)

>> drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c:120:2: warning: Local variable ret shadows outer variable [shadowVar]
    dsi_dcs_write_seq(dsi, 0x4f, 0x01);
    ^
   drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c:105:6: note: Shadowed declaration
    int ret;
        ^
   drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c:120:2: note: Shadow variable
    dsi_dcs_write_seq(dsi, 0x4f, 0x01);
    ^

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=02ed76b6da0710a9d24f36a4a9800a68d7edb9a7
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout 02ed76b6da0710a9d24f36a4a9800a68d7edb9a7
vim +120 drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c

02ed76b6da0710a Konrad Dybcio 2020-05-06  101  static int tm5p5_nt35596_off(struct tm5p5_nt35596 *ctx)
02ed76b6da0710a Konrad Dybcio 2020-05-06  102  {
02ed76b6da0710a Konrad Dybcio 2020-05-06  103  	struct mipi_dsi_device *dsi = ctx->dsi;
02ed76b6da0710a Konrad Dybcio 2020-05-06  104  	struct device *dev = &dsi->dev;
02ed76b6da0710a Konrad Dybcio 2020-05-06  105  	int ret;
02ed76b6da0710a Konrad Dybcio 2020-05-06  106  
02ed76b6da0710a Konrad Dybcio 2020-05-06  107  	ret = mipi_dsi_dcs_set_display_off(dsi);
02ed76b6da0710a Konrad Dybcio 2020-05-06  108  	if (ret < 0) {
02ed76b6da0710a Konrad Dybcio 2020-05-06  109  		dev_err(dev, "Failed to set display off: %d\n", ret);
02ed76b6da0710a Konrad Dybcio 2020-05-06  110  		return ret;
02ed76b6da0710a Konrad Dybcio 2020-05-06  111  	}
02ed76b6da0710a Konrad Dybcio 2020-05-06  112  	msleep(60);
02ed76b6da0710a Konrad Dybcio 2020-05-06  113  
02ed76b6da0710a Konrad Dybcio 2020-05-06  114  	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
02ed76b6da0710a Konrad Dybcio 2020-05-06  115  	if (ret < 0) {
02ed76b6da0710a Konrad Dybcio 2020-05-06  116  		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
02ed76b6da0710a Konrad Dybcio 2020-05-06  117  		return ret;
02ed76b6da0710a Konrad Dybcio 2020-05-06  118  	}
02ed76b6da0710a Konrad Dybcio 2020-05-06  119  
02ed76b6da0710a Konrad Dybcio 2020-05-06 @120  	dsi_dcs_write_seq(dsi, 0x4f, 0x01);

It's a really bad idea to hide a return inside a macro.  It will lead to
all sorts of locking and error handling bugs.

02ed76b6da0710a Konrad Dybcio 2020-05-06  121  
02ed76b6da0710a Konrad Dybcio 2020-05-06  122  	return 0;
02ed76b6da0710a Konrad Dybcio 2020-05-06  123  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org
