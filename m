Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6FBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190B3207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YKwSEsxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgFLJLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:11:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37486 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLJLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:11:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05C93WoU069377;
        Fri, 12 Jun 2020 09:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type;
 s=corp-2020-01-29; bh=C/dA11NOfjy5EzqfZ2evxlvo5kBXwAXBNnAa7QQRN2I=;
 b=YKwSEsxgOV6NU+G9UwM6ydTaeKtpAaTs/1/A4h/N/nzpQtb5fypH4JmDJNV3Z+y//fHq
 D95eaPLkQrbrPrN3oMsLLlEAU8c84ZuGpOxew0xezbtK06Kz0U8SGVYzWRZOsstlucv/
 0In2XFcupQSh5CTgN5SK1ciHPJKD0sV9tBrXcLNzR/weEPN07hO1tY+fgnwOgIzddEX4
 Y4b5rypztjZ4E+1yF/+Y5aRw7gt98L1NpYCZ1RFVRVECe8nJZ1WAlWPD9gWgqPK6XYV6
 BAHEvAF8m52Wa+QTrkN+iqptyeR5Tt6RmwF7LZZW5moYLNsE2Ywtlc63NVjiJnsmMNkm 5Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31g2jrm41a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 09:11:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05C949MM090436;
        Fri, 12 Jun 2020 09:09:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31m6rj09up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 09:09:00 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05C93wKH003154;
        Fri, 12 Jun 2020 09:03:58 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 12 Jun 2020 02:02:39 -0700
USER-AGENT: Mutt/1.9.4 (2018-02-28)
MIME-Version: 1.0
Message-ID: <20200612090233.GG4151@kadam>
Date:   Fri, 12 Jun 2020 02:02:33 -0700 (PDT)
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Harald Freudenberger <freude@linux.ibm.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
Subject: drivers/s390/crypto/zcrypt_api.c:986 _zcrypt_send_ep11_cprb() error:
 uninitialized symbol 'pref_weight'.
Content-Type: multipart/mixed;
 boundary="__159195263794557863abhmp0007.oracle.com"
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--__159195263794557863abhmp0007.oracle.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b29482fde649c72441d5478a4ea2c52c56d97a5e
commit: a7367997abb64b5e5a4f6fe6091629440b10da40 s390/zcrypt: ep11 structs rework, export zcrypt_send_ep11_cprb
config: s390-randconfig-m031-20200611 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/s390/crypto/zcrypt_api.c:986 _zcrypt_send_ep11_cprb() error: uninitialized symbol 'pref_weight'.
drivers/s390/crypto/zcrypt_api.c:1008 _zcrypt_send_ep11_cprb() error: uninitialized symbol 'weight'.

Old smatch warnings:
drivers/s390/crypto/zcrypt_api.c:676 zcrypt_rsa_modexpo() error: uninitialized symbol 'pref_weight'.
drivers/s390/crypto/zcrypt_api.c:694 zcrypt_rsa_modexpo() error: uninitialized symbol 'weight'.
drivers/s390/crypto/zcrypt_api.c:760 zcrypt_rsa_crt() error: uninitialized symbol 'pref_weight'.
drivers/s390/crypto/zcrypt_api.c:778 zcrypt_rsa_crt() error: uninitialized symbol 'weight'.
drivers/s390/crypto/zcrypt_api.c:824 _zcrypt_send_cprb() warn: always true condition '(tdom >= 0) => (0-u16max >= 0)'
drivers/s390/crypto/zcrypt_api.c:846 _zcrypt_send_cprb() error: uninitialized symbol 'pref_weight'.
drivers/s390/crypto/zcrypt_api.c:867 _zcrypt_send_cprb() error: uninitialized symbol 'weight'.
drivers/s390/crypto/zcrypt_api.c:1065 zcrypt_rng() error: uninitialized symbol 'pref_weight'.
drivers/s390/crypto/zcrypt_api.c:1079 zcrypt_rng() error: uninitialized symbol 'weight'.

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a7367997abb64b5e5a4f6fe6091629440b10da40
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout a7367997abb64b5e5a4f6fe6091629440b10da40
vim +/pref_weight +986 drivers/s390/crypto/zcrypt_api.c

a7367997abb64b Harald Freudenberger 2019-08-30   926  static long _zcrypt_send_ep11_cprb(struct ap_perms *perms,
00fab2350e6b91 Harald Freudenberger 2018-09-17   927  				   struct ep11_urb *xcrb)
91f3e3eaba4413 Ingo Tuchscherer     2013-11-20   928  {
e28d2af43614eb Ingo Tuchscherer     2016-08-25   929  	struct zcrypt_card *zc, *pref_zc;
e28d2af43614eb Ingo Tuchscherer     2016-08-25   930  	struct zcrypt_queue *zq, *pref_zq;
e28d2af43614eb Ingo Tuchscherer     2016-08-25   931  	struct ep11_target_dev *targets;
e28d2af43614eb Ingo Tuchscherer     2016-08-25   932  	unsigned short target_num;
e28d2af43614eb Ingo Tuchscherer     2016-08-25   933  	unsigned int weight, pref_weight;
e28d2af43614eb Ingo Tuchscherer     2016-08-25   934  	unsigned int func_code;
34a15167739412 Ingo Tuchscherer     2016-08-25   935  	struct ap_message ap_msg;
13b251bdc8b97c Harald Freudenberger 2016-11-25   936  	int qid = 0, rc = -ENODEV;
01396a374c3d31 Harald Freudenberger 2019-02-22   937  	struct module *mod;
13b251bdc8b97c Harald Freudenberger 2016-11-25   938  
13b251bdc8b97c Harald Freudenberger 2016-11-25   939  	trace_s390_zcrypt_req(xcrb, TP_ZSENDEP11CPRB);
91f3e3eaba4413 Ingo Tuchscherer     2013-11-20   940  
89a0c0ec0d2e3c Harald Freudenberger 2018-05-28   941  	ap_init_message(&ap_msg);
89a0c0ec0d2e3c Harald Freudenberger 2018-05-28   942  
e28d2af43614eb Ingo Tuchscherer     2016-08-25   943  	target_num = (unsigned short) xcrb->targets_num;
91f3e3eaba4413 Ingo Tuchscherer     2013-11-20   944  
91f3e3eaba4413 Ingo Tuchscherer     2013-11-20   945  	/* empty list indicates autoselect (all available targets) */
e28d2af43614eb Ingo Tuchscherer     2016-08-25   946  	targets = NULL;
e28d2af43614eb Ingo Tuchscherer     2016-08-25   947  	if (target_num != 0) {
e28d2af43614eb Ingo Tuchscherer     2016-08-25   948  		struct ep11_target_dev __user *uptr;
e28d2af43614eb Ingo Tuchscherer     2016-08-25   949  
e28d2af43614eb Ingo Tuchscherer     2016-08-25   950  		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
13b251bdc8b97c Harald Freudenberger 2016-11-25   951  		if (!targets) {
913140e221567b Arnd Bergmann        2019-04-08   952  			func_code = 0;
13b251bdc8b97c Harald Freudenberger 2016-11-25   953  			rc = -ENOMEM;
13b251bdc8b97c Harald Freudenberger 2016-11-25   954  			goto out;
13b251bdc8b97c Harald Freudenberger 2016-11-25   955  		}
91f3e3eaba4413 Ingo Tuchscherer     2013-11-20   956  
e28d2af43614eb Ingo Tuchscherer     2016-08-25   957  		uptr = (struct ep11_target_dev __force __user *) xcrb->targets;
e28d2af43614eb Ingo Tuchscherer     2016-08-25   958  		if (copy_from_user(targets, uptr,
13b251bdc8b97c Harald Freudenberger 2016-11-25   959  				   target_num * sizeof(*targets))) {
913140e221567b Arnd Bergmann        2019-04-08   960  			func_code = 0;
13b251bdc8b97c Harald Freudenberger 2016-11-25   961  			rc = -EFAULT;
89a0c0ec0d2e3c Harald Freudenberger 2018-05-28   962  			goto out_free;
13b251bdc8b97c Harald Freudenberger 2016-11-25   963  		}
91f3e3eaba4413 Ingo Tuchscherer     2013-11-20   964  	}
91f3e3eaba4413 Ingo Tuchscherer     2013-11-20   965  
34a15167739412 Ingo Tuchscherer     2016-08-25   966  	rc = get_ep11cprb_fc(xcrb, &ap_msg, &func_code);
34a15167739412 Ingo Tuchscherer     2016-08-25   967  	if (rc)
e28d2af43614eb Ingo Tuchscherer     2016-08-25   968  		goto out_free;
34a15167739412 Ingo Tuchscherer     2016-08-25   969  
e28d2af43614eb Ingo Tuchscherer     2016-08-25   970  	pref_zc = NULL;
e28d2af43614eb Ingo Tuchscherer     2016-08-25   971  	pref_zq = NULL;
e28d2af43614eb Ingo Tuchscherer     2016-08-25   972  	spin_lock(&zcrypt_list_lock);
e28d2af43614eb Ingo Tuchscherer     2016-08-25   973  	for_each_zcrypt_card(zc) {
e28d2af43614eb Ingo Tuchscherer     2016-08-25   974  		/* Check for online EP11 cards */
e28d2af43614eb Ingo Tuchscherer     2016-08-25   975  		if (!zc->online || !(zc->card->functions & 0x04000000))
91f3e3eaba4413 Ingo Tuchscherer     2013-11-20   976  			continue;
e28d2af43614eb Ingo Tuchscherer     2016-08-25   977  		/* Check for user selected EP11 card */
e28d2af43614eb Ingo Tuchscherer     2016-08-25   978  		if (targets &&
e28d2af43614eb Ingo Tuchscherer     2016-08-25   979  		    !is_desired_ep11_card(zc->card->id, target_num, targets))
91f3e3eaba4413 Ingo Tuchscherer     2013-11-20   980  			continue;
00fab2350e6b91 Harald Freudenberger 2018-09-17   981  		/* check if device node has admission for this card */
00fab2350e6b91 Harald Freudenberger 2018-09-17   982  		if (!zcrypt_check_card(perms, zc->card->id))
00fab2350e6b91 Harald Freudenberger 2018-09-17   983  			continue;
e28d2af43614eb Ingo Tuchscherer     2016-08-25   984  		/* get weight index of the card device	*/
e28d2af43614eb Ingo Tuchscherer     2016-08-25   985  		weight = speed_idx_ep11(func_code) * zc->speed_rating[SECKEY];
e47de21dd35bad Ingo Tuchscherer     2016-10-14  @986  		if (zcrypt_card_compare(zc, pref_zc, weight, pref_weight))
                                                                                                             ^^^^^^^^^^^
Not initialized on first iteration through the loop.

34a15167739412 Ingo Tuchscherer     2016-08-25   987  			continue;
e28d2af43614eb Ingo Tuchscherer     2016-08-25   988  		for_each_zcrypt_queue(zq, zc) {
e28d2af43614eb Ingo Tuchscherer     2016-08-25   989  			/* check if device is online and eligible */
e28d2af43614eb Ingo Tuchscherer     2016-08-25   990  			if (!zq->online ||
148784246ef2d8 Harald Freudenberger 2016-10-27   991  			    !zq->ops->send_ep11_cprb ||
e28d2af43614eb Ingo Tuchscherer     2016-08-25   992  			    (targets &&
e28d2af43614eb Ingo Tuchscherer     2016-08-25   993  			     !is_desired_ep11_queue(zq->queue->qid,
e28d2af43614eb Ingo Tuchscherer     2016-08-25   994  						    target_num, targets)))
34a15167739412 Ingo Tuchscherer     2016-08-25   995  				continue;
00fab2350e6b91 Harald Freudenberger 2018-09-17   996  			/* check if device node has admission for this queue */
00fab2350e6b91 Harald Freudenberger 2018-09-17   997  			if (!zcrypt_check_queue(perms,
00fab2350e6b91 Harald Freudenberger 2018-09-17   998  						AP_QID_QUEUE(zq->queue->qid)))
00fab2350e6b91 Harald Freudenberger 2018-09-17   999  				continue;
e47de21dd35bad Ingo Tuchscherer     2016-10-14  1000  			if (zcrypt_queue_compare(zq, pref_zq,
e47de21dd35bad Ingo Tuchscherer     2016-10-14  1001  						 weight, pref_weight))
e28d2af43614eb Ingo Tuchscherer     2016-08-25  1002  				continue;
e28d2af43614eb Ingo Tuchscherer     2016-08-25  1003  			pref_zc = zc;
e28d2af43614eb Ingo Tuchscherer     2016-08-25  1004  			pref_zq = zq;
e28d2af43614eb Ingo Tuchscherer     2016-08-25  1005  			pref_weight = weight;
34a15167739412 Ingo Tuchscherer     2016-08-25  1006  		}
34a15167739412 Ingo Tuchscherer     2016-08-25  1007  	}
01396a374c3d31 Harald Freudenberger 2019-02-22 @1008  	pref_zq = zcrypt_pick_queue(pref_zc, pref_zq, &mod, weight);
                                                                                                            ^^^^^^
From a static analysis perspective it's obvious why it generates a
warning for this, but it's probably wrong.

e28d2af43614eb Ingo Tuchscherer     2016-08-25  1009  	spin_unlock(&zcrypt_list_lock);
e28d2af43614eb Ingo Tuchscherer     2016-08-25  1010  
e28d2af43614eb Ingo Tuchscherer     2016-08-25  1011  	if (!pref_zq) {
e28d2af43614eb Ingo Tuchscherer     2016-08-25  1012  		rc = -ENODEV;
e28d2af43614eb Ingo Tuchscherer     2016-08-25  1013  		goto out_free;
34a15167739412 Ingo Tuchscherer     2016-08-25  1014  	}
34a15167739412 Ingo Tuchscherer     2016-08-25  1015  
13b251bdc8b97c Harald Freudenberger 2016-11-25  1016  	qid = pref_zq->queue->qid;
e28d2af43614eb Ingo Tuchscherer     2016-08-25  1017  	rc = pref_zq->ops->send_ep11_cprb(pref_zq, xcrb, &ap_msg);
e28d2af43614eb Ingo Tuchscherer     2016-08-25  1018  
e28d2af43614eb Ingo Tuchscherer     2016-08-25  1019  	spin_lock(&zcrypt_list_lock);
01396a374c3d31 Harald Freudenberger 2019-02-22  1020  	zcrypt_drop_queue(pref_zc, pref_zq, mod, weight);
e28d2af43614eb Ingo Tuchscherer     2016-08-25  1021  	spin_unlock(&zcrypt_list_lock);
e28d2af43614eb Ingo Tuchscherer     2016-08-25  1022  
e28d2af43614eb Ingo Tuchscherer     2016-08-25  1023  out_free:
e28d2af43614eb Ingo Tuchscherer     2016-08-25  1024  	kfree(targets);
13b251bdc8b97c Harald Freudenberger 2016-11-25  1025  out:
89a0c0ec0d2e3c Harald Freudenberger 2018-05-28  1026  	ap_release_message(&ap_msg);
13b251bdc8b97c Harald Freudenberger 2016-11-25  1027  	trace_s390_zcrypt_rep(xcrb, func_code, rc,
13b251bdc8b97c Harald Freudenberger 2016-11-25  1028  			      AP_QID_CARD(qid), AP_QID_QUEUE(qid));
91f3e3eaba4413 Ingo Tuchscherer     2013-11-20  1029  	return rc;
91f3e3eaba4413 Ingo Tuchscherer     2013-11-20  1030  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--__159195263794557863abhmp0007.oracle.com
Content-Type: application/gzip; charset=ascii; name=".config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=".config.gz"

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
ZKTsf7C2QWxaZwEA

--__159195263794557863abhmp0007.oracle.com--
