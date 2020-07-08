Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C05BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B39206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgGHJrM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:47:12 -0400
Received: from mgw-02.mpynet.fi ([82.197.21.91]:59032 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbgGHJrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:47:12 -0400
X-Greylist: delayed 1081 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2020 05:47:07 EDT
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 0689Mosc093817;
        Wed, 8 Jul 2020 12:28:45 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 322dewmgn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 12:28:44 +0300
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Jul 2020 12:28:44 +0300
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.006; Wed, 8 Jul 2020 12:28:44 +0300
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Luca Stefani <luca.stefani.ge1@gmail.com>
CC:     clang-built-linux <clang-built-linux@googlegroups.com>,
        freak07 <michalechner92@googlemail.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] ntfs: Fix ntfs_test_inode and ntfs_init_locked_inode
 function type
Thread-Topic: [PATCH] ntfs: Fix ntfs_test_inode and ntfs_init_locked_inode
 function type
Thread-Index: AQHWTLWIk5EfUBFiEUSTit3kCmYXJajv8dOAgA1Wz4A=
Date:   Wed, 8 Jul 2020 09:28:43 +0000
Message-ID: <8CDE123D-68C3-44E9-B8CC-7159E4640762@tuxera.com>
References: <20200627190230.1191796-1-luca.stefani.ge1@gmail.com>
 <CAKwvOdk5_tq6hrBMEwssksGniMyAWSMKOSaWbiBsX_bssmmztA@mail.gmail.com>
In-Reply-To: <CAKwvOdk5_tq6hrBMEwssksGniMyAWSMKOSaWbiBsX_bssmmztA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [109.157.43.234]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <797207C2DA74744289BFE57326571F92@ex13.tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_07:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007080068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

Apologies for taking this long to respond.  I have to admit I was not familiar with CFI...  Your patch looks good but please could you update the commit message as suggested by Nick to include explanation of CFI?  You can then add:

Acked-by: Anton Altaparmakov <anton@tuxera.com>

When resending please CC: Andrew Morton <akpm@linux-foundation.org> so we can get it merged upstream.

Thanks a lot!

Best regards,

	Anton

> On 29 Jun 2020, at 22:46, Nick Desaulniers <ndesaulniers@google.com> wrote:
> 
> On Sat, Jun 27, 2020 at 12:02 PM Luca Stefani
> <luca.stefani.ge1@gmail.com> wrote:
>> 
>> If the kernel is built with CFI we hit a __cfi_check_fail
>> while mounting a partition
> 
> Luca,
> Since CFI is not yet upstream (is downstream in Android, blocked on
> LTO patches currently working their way through upstreaming+code
> review), it might help explain to reviewers what CFI *even is*.
> Something like:
> 
> """
> Clang's Control Flow Integrity (CFI) is a security mechanism that can
> help prevent JOP chains, deployed extensively in downstream kernels
> used in Android.
> 
> It's deployment is hindered by mismatches in function signatures.  For
> this case, we make callbacks match their intended function signature,
> and cast parameters within them rather than casting the callback when
> passed as a parameter.
> 
> When running `mount -t ntfs ...` we observe the following trace:
> """
> 
> I also always recommend setting an explicit `--to=` when sending
> patches; some maintainers only know to take a look at patches if
> they're in the To: list.  Maybe they have email filters on this.  You
> can you `./script/get_maintainer.pl` on your patch file, or manually
> check MAINTAINERS.  In this case, it looks like Anton is cc'ed at
> least.
> 
> Since this patch modifies the type signature of callbacks to the
> expected type, casting the callback's parameters instead; I'm happy
> with this patch.  The callbacks never get invoked directly (not
> explicitly called, only invoked indirectly), there is no argument for
> loss of type safety (the interfaces are already lossy in that the
> interface uses void* parameters).  I just would like the commit
> message beefed up before I sign off.  Are you comfortable sending a
> V2?
> 
> More on JOP/CFI:
> https://www.comp.nus.edu.sg/~liangzk/papers/asiaccs11.pdf
>> CFI has not seen wide deployment, likely due to concerns over performance, especially in the case of real-time enforcement.
> 
>> 
>> Call trace:
>> __cfi_check_fail+0x1c/0x24
>> name_to_dev_t+0x0/0x404
>> iget5_locked+0x594/0x5e8
>> ntfs_fill_super+0xbfc/0x43ec
>> mount_bdev+0x30c/0x3cc
>> ntfs_mount+0x18/0x24
>> mount_fs+0x1b0/0x380
>> vfs_kern_mount+0x90/0x398
>> do_mount+0x5d8/0x1a10
>> SyS_mount+0x108/0x144
>> el0_svc_naked+0x34/0x38
>> 
>> Fixing iget5_locked and ilookup5 callers seems enough
>> 
>> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
>> Tested-by: freak07 <michalechner92@googlemail.com>
>> ---
>> fs/ntfs/dir.c   |  2 +-
>> fs/ntfs/inode.c | 23 ++++++++++++-----------
>> fs/ntfs/inode.h |  4 +---
>> fs/ntfs/mft.c   |  4 ++--
>> 4 files changed, 16 insertions(+), 17 deletions(-)
>> 
>> diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
>> index 3c4811469ae8..e278bfc5ee7f 100644
>> --- a/fs/ntfs/dir.c
>> +++ b/fs/ntfs/dir.c
>> @@ -1503,7 +1503,7 @@ static int ntfs_dir_fsync(struct file *filp, loff_t start, loff_t end,
>>        na.type = AT_BITMAP;
>>        na.name = I30;
>>        na.name_len = 4;
>> -       bmp_vi = ilookup5(vi->i_sb, vi->i_ino, (test_t)ntfs_test_inode, &na);
>> +       bmp_vi = ilookup5(vi->i_sb, vi->i_ino, ntfs_test_inode, &na);
> 
> Looks like the signature of ilookup5 is:
> 
> struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
>     int (*test)(struct inode *, void *), void *data)
> 
> while ntfs_test_inode is:
> 
> int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
> 
> while test_t is defined way below to:
> 
> typedef int (*test_t)(struct inode *, void *);
> 
> 
>>        if (bmp_vi) {
>>                write_inode_now(bmp_vi, !datasync);
>>                iput(bmp_vi);
>> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
>> index d4359a1df3d5..a5d3bebe7a85 100644
>> --- a/fs/ntfs/inode.c
>> +++ b/fs/ntfs/inode.c
>> @@ -30,7 +30,7 @@
>> /**
>>  * ntfs_test_inode - compare two (possibly fake) inodes for equality
>>  * @vi:                vfs inode which to test
>> - * @na:                ntfs attribute which is being tested with
>> + * @data:              data which is being tested with
>>  *
>>  * Compare the ntfs attribute embedded in the ntfs specific part of the vfs
>>  * inode @vi for equality with the ntfs attribute @na.
>> @@ -43,8 +43,9 @@
>>  * NOTE: This function runs with the inode_hash_lock spin lock held so it is not
>>  * allowed to sleep.
>>  */
>> -int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
>> +int ntfs_test_inode(struct inode *vi, void *data)
>> {
>> +       ntfs_attr *na = (ntfs_attr *)data;
>>        ntfs_inode *ni;
>> 
>>        if (vi->i_ino != na->mft_no)
>> @@ -72,7 +73,7 @@ int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
>> /**
>>  * ntfs_init_locked_inode - initialize an inode
>>  * @vi:                vfs inode to initialize
>> - * @na:                ntfs attribute which to initialize @vi to
>> + * @data:              data which to initialize @vi to
>>  *
>>  * Initialize the vfs inode @vi with the values from the ntfs attribute @na in
>>  * order to enable ntfs_test_inode() to do its work.
>> @@ -87,8 +88,9 @@ int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
>>  * NOTE: This function runs with the inode->i_lock spin lock held so it is not
>>  * allowed to sleep. (Hence the GFP_ATOMIC allocation.)
>>  */
>> -static int ntfs_init_locked_inode(struct inode *vi, ntfs_attr *na)
>> +static int ntfs_init_locked_inode(struct inode *vi, void *data)
>> {
>> +       ntfs_attr *na = (ntfs_attr *)data;
>>        ntfs_inode *ni = NTFS_I(vi);
>> 
>>        vi->i_ino = na->mft_no;
>> @@ -131,7 +133,6 @@ static int ntfs_init_locked_inode(struct inode *vi, ntfs_attr *na)
>>        return 0;
>> }
>> 
>> -typedef int (*set_t)(struct inode *, void *);
>> static int ntfs_read_locked_inode(struct inode *vi);
>> static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi);
>> static int ntfs_read_locked_index_inode(struct inode *base_vi,
>> @@ -164,8 +165,8 @@ struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no)
>>        na.name = NULL;
>>        na.name_len = 0;
>> 
>> -       vi = iget5_locked(sb, mft_no, (test_t)ntfs_test_inode,
>> -                       (set_t)ntfs_init_locked_inode, &na);
>> +       vi = iget5_locked(sb, mft_no, ntfs_test_inode,
>> +                       ntfs_init_locked_inode, &na);
>>        if (unlikely(!vi))
>>                return ERR_PTR(-ENOMEM);
>> 
>> @@ -225,8 +226,8 @@ struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPE type,
>>        na.name = name;
>>        na.name_len = name_len;
>> 
>> -       vi = iget5_locked(base_vi->i_sb, na.mft_no, (test_t)ntfs_test_inode,
>> -                       (set_t)ntfs_init_locked_inode, &na);
>> +       vi = iget5_locked(base_vi->i_sb, na.mft_no, ntfs_test_inode,
>> +                       ntfs_init_locked_inode, &na);
>>        if (unlikely(!vi))
>>                return ERR_PTR(-ENOMEM);
>> 
>> @@ -280,8 +281,8 @@ struct inode *ntfs_index_iget(struct inode *base_vi, ntfschar *name,
>>        na.name = name;
>>        na.name_len = name_len;
>> 
>> -       vi = iget5_locked(base_vi->i_sb, na.mft_no, (test_t)ntfs_test_inode,
>> -                       (set_t)ntfs_init_locked_inode, &na);
>> +       vi = iget5_locked(base_vi->i_sb, na.mft_no, ntfs_test_inode,
>> +                       ntfs_init_locked_inode, &na);
>>        if (unlikely(!vi))
>>                return ERR_PTR(-ENOMEM);
>> 
>> diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
>> index 98e670fbdd31..363e4e820673 100644
>> --- a/fs/ntfs/inode.h
>> +++ b/fs/ntfs/inode.h
>> @@ -253,9 +253,7 @@ typedef struct {
>>        ATTR_TYPE type;
>> } ntfs_attr;
>> 
>> -typedef int (*test_t)(struct inode *, void *);
>> -
>> -extern int ntfs_test_inode(struct inode *vi, ntfs_attr *na);
>> +extern int ntfs_test_inode(struct inode *vi, void *data);
>> 
>> extern struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no);
>> extern struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPE type,
>> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
>> index fbb9f1bc623d..0d62cd5bb7f8 100644
>> --- a/fs/ntfs/mft.c
>> +++ b/fs/ntfs/mft.c
>> @@ -958,7 +958,7 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
>>                 * dirty code path of the inode dirty code path when writing
>>                 * $MFT occurs.
>>                 */
>> -               vi = ilookup5_nowait(sb, mft_no, (test_t)ntfs_test_inode, &na);
>> +               vi = ilookup5_nowait(sb, mft_no, ntfs_test_inode, &na);
>>        }
>>        if (vi) {
>>                ntfs_debug("Base inode 0x%lx is in icache.", mft_no);
>> @@ -1019,7 +1019,7 @@ bool ntfs_may_write_mft_record(ntfs_volume *vol, const unsigned long mft_no,
>>                vi = igrab(mft_vi);
>>                BUG_ON(vi != mft_vi);
>>        } else
>> -               vi = ilookup5_nowait(sb, na.mft_no, (test_t)ntfs_test_inode,
>> +               vi = ilookup5_nowait(sb, na.mft_no, ntfs_test_inode,
>>                                &na);
>>        if (!vi) {
>>                /*
>> --
>> 2.26.2
>> 
>> --
>> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200627190230.1191796-1-luca.stefani.ge1%40gmail.com.
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers


-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

