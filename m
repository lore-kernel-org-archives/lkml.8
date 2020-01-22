Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F853C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F20C24684
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KCsxNkbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgAVIOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:14:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43520 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgAVIOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:14:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00M8DPMC193888;
        Wed, 22 Jan 2020 08:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=83DRZ5lvnyecxdZB0/wPFCJp9LCv2JjGJqQI51XrkwA=;
 b=KCsxNkbx1umn0gPsVd/zq9L7Al0fxcKzUkcGPQpZHMQdfL5c6iZwtAafC6LWPn59J9/a
 vRhwBJ+e0Rja3jOkorDb6GJ+uixhNEhuS6nFADC8Obm3nV2WW9kpmAiz0kSy9kLx7Jnv
 DueoHad5C5sLMpUFM5VqK+HmBdsqdPIrQrijTABbYE1qh9yfJTS0RV6LBswWPEqvERj3
 r61tDhCcGMXladw290sgTsqYOERCDBbiqM89iDsCpJeAXdMew7lBGLSv+83aF2tqp58u
 lzsXetYMrVM5GCdUFF/z6zTHnl8Z665EzGeij7V8OgiGQT4Ca6qo8Ua0XmnELt4sQzqO Rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xksyqa268-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jan 2020 08:14:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00M8Dqrg177405;
        Wed, 22 Jan 2020 08:14:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2xnpfqqn85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jan 2020 08:14:08 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00M8DlC4021757;
        Wed, 22 Jan 2020 08:13:48 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Jan 2020 00:13:47 -0800
Date:   Wed, 22 Jan 2020 11:13:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     syzbot <syzbot+b904ba7c947a37b4b291@syzkaller.appspotmail.com>,
        dhowells@redhat.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in __proc_create (2)
Message-ID: <20200122081340.2bhx5jfezl55b3qb@kili.mountain>
References: <000000000000da7a79059caf2656@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000000000000da7a79059caf2656@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9507 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=918
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001220074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9507 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=983 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001220074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 03:56:08PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    d96d875e Merge tag 'fixes_for_v5.5-rc8' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13b7b80de00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=83c00afca9cf5153
> dashboard link: https://syzkaller.appspot.com/bug?extid=b904ba7c947a37b4b291
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c96185e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f859c9e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b904ba7c947a37b4b291@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> name '��/]uwo,"� c�ac�����[� $�5x~�s�&�tw}���z �cp ('
          ^

Hi David,

We should probably ban '/' characters from the cell name in
afs_alloc_cell().

regards,
dan carpenter

