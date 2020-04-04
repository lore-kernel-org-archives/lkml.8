Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4F9C2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F265120644
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WslufRIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgDDPfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 11:35:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47262 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgDDPfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 11:35:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 034FRsCm040152;
        Sat, 4 Apr 2020 15:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 content-transfer-encoding : from : mime-version : subject : message-id :
 date : cc : to; s=corp-2020-01-29;
 bh=DLf2vhWBRYv3EPu/oUxKTRyjQV56vIPOgQY2nOhxbP0=;
 b=WslufRIL4441F25A+QBTCYAvUFxpAc0TRPSF1dIj+BChAWs6c2cO2rQ4nUHDth3qjSU6
 O5NOJIubS+o1Ir+rPaKDuezDh+zlpd9WF3stAb70LdJ7ZZLrL0H4sZ40wwQLc7NMgOw4
 mo8V7c3Yfd0B6zKvkRrZFAbDPvLpnxf7eswqn8Ggx2sM+nugQZe3dwJU1qtYbVNICu6T
 6suba0EPMWOc/GSq7/+Df5dCk1tkdhl+Xu68FXEvcornLYFH7aSV8Xz0j7GBLeq9iBWr
 dtuy8K20p41vkntWsmnlc8bLYZh0V/1DTFyUp+t+ilNU44qglD/ZmYFnsNCDcZleKJO0 yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 306j6m1650-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Apr 2020 15:35:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 034FRG0e100081;
        Sat, 4 Apr 2020 15:35:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 306j21fub1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Apr 2020 15:35:06 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 034FZ4nb019828;
        Sat, 4 Apr 2020 15:35:04 GMT
Received: from [10.0.0.106] (/76.25.178.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 04 Apr 2020 08:35:04 -0700
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   William Kucharski <william.kucharski@oracle.com>
Mime-Version: 1.0 (1.0)
Subject: Re:   [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
Message-Id: <D25C4027-6EF9-44C2-AD4D-DDC785288B9A@oracle.com>
Date:   Sat, 4 Apr 2020 09:35:02 -0600
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jroedel@suse.de,
        vbabka@suse.cz, urezki@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17F5034c)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9581 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxlogscore=582 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004040145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9581 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=659 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004040145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=EF=BB=BFIs there any need to similarly sanitize =E2=80=9Csize=E2=80=9D to a=
ssure start + size doesn=E2=80=99t go past =E2=80=9Cend?=E2=80=9D

> On Apr 3, 2020, at 10:33, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> =EF=BB=BF
> __get_vm_area() is an exported symbol, make sure the callers stay in
> the expected memory range. When calling this function with memory
> ranges outside of the VMALLOC range *bad* things can happen.

