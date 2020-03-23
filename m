Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9749CC4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE9D206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uE8Qkvw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgCWLm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:42:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33722 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgCWLm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 07:42:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NBdECu114405;
        Mon, 23 Mar 2020 11:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=M30jtPOLXFGKh0OiBXL0iPiQWOfFHuziHXXkfFK5U2A=;
 b=uE8Qkvw2f3iHluL4afcTXM89lN+Rk8kalQNFUp6khL4h8gwllbrTeC571hY/4dbu1g3U
 ENC9sI6rW4qhccdHsYwSYmrHyzCRq2zKBt8LK760Lxgzf/BfzozNLTCio1sbx0Q1gKzC
 kLnf6bcxj+7cc5bRK8Od8AK2oIpPcHmkSVxoDrfdX94z/FJXGVJRF0fJzCtVHq+AZOvy
 4Qr5g3phfgZa+TZpTuTqQP7fxUNc/guPC/z+g0WEeJfC65kSmX99YPbgW3yQvXxFoS58
 bUouP3AGJ/BEez8IFVRqoNihkPPE/7TvQ3AMpc6nZEhRN4/z92pEJtsElpqUXgAfOHlf ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ywabqx2yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 11:42:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NBfv2U064536;
        Mon, 23 Mar 2020 11:42:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2ywvqqywbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 11:42:37 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02NBgX4V004477;
        Mon, 23 Mar 2020 11:42:34 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Mar 2020 04:42:33 -0700
Date:   Mon, 23 Mar 2020 14:42:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Qiujun Huang <anenbupt@gmail.com>
Cc:     syzbot <syzbot+4a88b2b9dc280f47baf4@syzkaller.appspotmail.com>,
        aeb@cwi.nl, danarag@gmail.com, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk
Subject: Re: KASAN: null-ptr-deref Write in get_block
Message-ID: <20200323114225.GE26299@kadam>
References: <000000000000cbeaf705a15a9b30@google.com>
 <CADG63jAEOBvWZ2G-9tyvHbbuKnHxNTPpqqjfWmhP7YVvsHVioQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADG63jAEOBvWZ2G-9tyvHbbuKnHxNTPpqqjfWmhP7YVvsHVioQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=2 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the subject to [PATCH] minix: Fix NULL dereference in alloc_branch()

On Sun, Mar 22, 2020 at 08:06:48PM +0800, Qiujun Huang wrote:
> Need to check the return value of sb_getblk.
> 

Add a Reported-by tag.

Reported-by: syzbot+4a88b2b9dc280f47baf4@syzkaller.appspotmail.com

> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  fs/minix/itree_common.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
> index 043c3fd..eedd79f 100644
> --- a/fs/minix/itree_common.c
> +++ b/fs/minix/itree_common.c
> @@ -85,6 +85,8 @@ static int alloc_branch(struct inode *inode,
>   break;
>   branch[n].key = cpu_to_block(nr);
>   bh = sb_getblk(inode->i_sb, parent);
> + if (!bh)
> + break;

The patch is white space damaged and we need to do a bit of error
handling before the break as well.

 	bh = sb_getblk(inode->i_sb, parent);
+	if (!bh) {
+		minix_free_block(inode, block_to_cpu(branch[n].key));
+		break;
+	}
 	lock_buffer(bh);

Please fix those few things and resend.

regards,
dan carpenter

