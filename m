Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B2FC2D0E8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 05:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B8C2075A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 05:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qCrkAdZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgDEF0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 01:26:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41870 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgDEF0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 01:26:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0355PtOB156367;
        Sun, 5 Apr 2020 05:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=X5r2bfLwDg5luV38v0Wr7SADIGbMruJAoCPFs9XImfs=;
 b=qCrkAdZiJjCBjTss/0fKUS+RgUy2q0tO4lncPAUAwfZzDyPedoRCAZ/S02cplJf/yvXV
 eWNMfI5eUkyVK4KzQXuo9IQG8/KhuzkFiUjF5FDgwzqteIn7mnS/ceWCcMPX6lguMUuh
 T4gFyzWcpVfeLU64w0zO2OpVcRNtbrSrVFtvpYn62g2hY+O2TwCZZ/BKW2kPJ9o3N76A
 3nnPWYe0qSJaHZekm/LnKYtSXgm59i4fdbsZFnrmGGkYjtMnK476HEnsh5zC0D1xwRba
 AVKHlQZLn9/vAUhmqdLv5fctyONsAA4megn+Und3jho4qHX+NFxGqvzfpzcY4T7i89dE 2A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 306hnqtdvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Apr 2020 05:25:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0355MHrs128371;
        Sun, 5 Apr 2020 05:25:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3073xt3q73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Apr 2020 05:25:55 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0355PlOY013071;
        Sun, 5 Apr 2020 05:25:47 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 04 Apr 2020 22:25:46 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200404185229.GA424@pc636>
Date:   Sat, 4 Apr 2020 23:25:45 -0600
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jroedel@suse.de,
        vbabka@suse.cz, Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EEB53CBF-0B3F-43E0-94F6-B001918BAC3E@oracle.com>
References: <D25C4027-6EF9-44C2-AD4D-DDC785288B9A@oracle.com>
 <20200404185229.GA424@pc636>
To:     Uladzislau Rezki <urezki@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9581 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=691
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004050051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9581 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=746
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004050051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 4, 2020, at 12:52 PM, Uladzislau Rezki <urezki@gmail.com> =
wrote:
>=20
>>=20
>> =EF=BB=BFIs there any need to similarly sanitize =E2=80=9Csize=E2=80=9D=
 to assure start + size doesn=E2=80=99t go past =E2=80=9Cend?=E2=80=9D
>>=20
> Why is that double check needed if all such tests are done deeper on =
stack?

If such tests ARE performed, then it doesn't matter to me whether it is =
checked before or after,
it just seems that nothing checks whether start + size makes some sort =
of sense with respect
to end.

I admit I didn't walk through all the routines to see if such a check =
would be superfluous.

