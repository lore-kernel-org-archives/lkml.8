Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510BBC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360BE2078A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgHXCBn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 22:01:43 -0400
Received: from mgw-01.mpynet.fi ([82.197.21.90]:40154 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727914AbgHXCBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 22:01:43 -0400
X-Greylist: delayed 1031 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Aug 2020 22:01:41 EDT
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 07O1Y27U013400;
        Mon, 24 Aug 2020 04:44:08 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 3342qur0yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 04:44:08 +0300
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Aug 2020 04:44:07 +0300
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.006; Mon, 24 Aug 2020 04:44:07 +0300
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Rustam Kovhaev <rkovhaev@gmail.com>
CC:     "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ntfs: add check for mft record size in superblock
Thread-Topic: [PATCH] ntfs: add check for mft record size in superblock
Thread-Index: AQHWeWEcxiS4EJ2kEU6+ZB9zUJco96lGSw4A
Date:   Mon, 24 Aug 2020 01:44:06 +0000
Message-ID: <F206DE99-102C-475D-9129-5B9ACBAED8E6@tuxera.com>
References: <20200823152147.55766-1-rkovhaev@gmail.com>
In-Reply-To: <20200823152147.55766-1-rkovhaev@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [109.145.212.211]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B6F2F1A9B99CD045AD3A609E096CD389@ex13.tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_01:2020-08-21,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rustam,

Thank you for the patch but it introduces an endianness bug - you have to us le32_to_cpu(m->bytes_allocated) both when doing the comparison and then printing the message.

Also, please drop the square brackets.  Wherever the driver prints such things it never uses brackets around the numbers and it would be better to have this consistent throughout.

Can you please resend with the above issues addressed?  You can then also add to the commit message:

	Acked-by: Anton Altaparmakov <anton@tuxera.com>

Thanks!

Best regards,

	Anton

> On 23 Aug 2020, at 16:21, Rustam Kovhaev <rkovhaev@gmail.com> wrote:
> 
> number of bytes allocated for mft record should be equal to the mft
> record size stored in ntfs superblock
> as reported by syzbot, userspace might trigger out-of-bounds read by
> dereferencing ctx->attr in ntfs_attr_find()
> 
> Reported-and-tested-by: syzbot+aed06913f36eff9b544e@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=aed06913f36eff9b544e
> Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
> ---
> fs/ntfs/inode.c | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 9bb9f0952b18..6407af7c2e4f 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -1810,6 +1810,12 @@ int ntfs_read_inode_mount(struct inode *vi)
> 		brelse(bh);
> 	}
> 
> +	if (m->bytes_allocated != vol->mft_record_size) {
> +		ntfs_error(sb, "Incorrect mft record size [%u] in superblock, should be [%u].",
> +				m->bytes_allocated, vol->mft_record_size);
> +		goto err_out;
> +	}
> +
> 	/* Apply the mst fixups. */
> 	if (post_read_mst_fixup((NTFS_RECORD*)m, vol->mft_record_size)) {
> 		/* FIXME: Try to use the $MFTMirr now. */
> -- 
> 2.28.0
> 


-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

