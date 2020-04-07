Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91042C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58ED620748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uqvNasyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgDGTLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:11:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45576 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgDGTLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:11:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037J84Ik060043;
        Tue, 7 Apr 2020 19:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=swajKYutGq2J/flsUm50gGY9cMazIJGr09EB2ZsOi40=;
 b=uqvNasyPkZpE0WsJm/4dH/pnZTwFH534H6Bpy3rYZYrfwrrqJ05K5H6q7F18wb3tTUmS
 rfeWUx0o7WvySvFmsuUL57BNGwbFfOc74I1kjs2wNlX42h5GpPurIvPuBSNY3oFLZYti
 DToHOgan1AWxGSRzkw7rCUKp6KRUjhjFNnQeKhDyi5M8/LggfceYItVbDjaSaE4EEJVV
 Jlh+CHAXc9W0cdThRXIhzCSn4k9TvQv6/a08YmXe1++VyHXAUbE1hwsRVQTsNtv7zHM3
 FYdaidr+anDEh310RLE+QEJQo4wrEdDoRN3tiTYQ7fysYCLp1CFnFT8V3vsAYkENA5P9 rQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 306j6mexrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 19:09:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037J7hUD095632;
        Tue, 7 Apr 2020 19:09:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3073qgxx5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 19:09:33 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 037J9WFu028390;
        Tue, 7 Apr 2020 19:09:32 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 12:09:32 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC] Renaming page_offset() to page_pos()
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200403153323.GQ21484@bombadil.infradead.org>
Date:   Tue, 7 Apr 2020 13:09:31 -0600
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE9117E6-D432-439D-836F-9805986C29DD@oracle.com>
References: <20200403153323.GQ21484@bombadil.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=827
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=875 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_pos seems quite reasonable to me.

Reviewed-by: William Kucharski <william.kucharski@oracle.com>


> On Apr 3, 2020, at 9:33 AM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> Without looking at the source, can you tell me what page_offset() =
does?
>=20
> At least one regular contributor thought it meant the pgoff_t of this
> page within the file.  It's actually the byte offset of this page into
> the file.
>=20
> We have a perfectly good name for byte offset into the file --
> file->f_pos.  So I propose renaming it to page_pos().  To minimise
> disruption to other development, I'm going to send Linus a pull =
request
> at the end of the merge window with the results of this coccinelle =
script:
>=20
> @@ expression a; @@
> -       page_offset(a)
> +       page_pos(a)
>=20
> I've reviewed the output and the only slight weirdness is an extra =
space
> in casts:
>=20
>                btrfs_warn(BTRFS_I(page->mapping->host)->root->fs_info,
>                           "page private not zero on page %llu",
> -                          (unsigned long long)page_offset(page));
> +                          (unsigned long long) page_pos(page));
>=20
> Sometimes Coccinelle fixes the surrounding whitespace to be better
> than it currently is:
>=20
> -               ow->bv[i].bv_len =3D min(page_offset(ow->pages[i]) + =
PAGE_SIZE,
> -                   ow->off + ow->len) -
> -                   max(ow->off, page_offset(ow->pages[i]));
> +               ow->bv[i].bv_len =3D min(page_pos(ow->pages[i]) + =
PAGE_SIZE,
> +                                      ow->off + ow->len) -
> +                   max(ow->off, page_pos(ow->pages[i]));
>=20
> (it's still bad, but it's an improvement)
>=20
> Any objections?  Anyone got a better name than page_pos()?
>=20

