Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA8EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D4D20842
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MhvOuSbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgCDDzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:55:06 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44924 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgCDDzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 22:55:06 -0500
Received: by mail-qk1-f195.google.com with SMTP id f198so300700qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 19:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WpdL8QZDYFesN5OhN9zP1zNf/fe8YGg+MSDVDDDuF8E=;
        b=MhvOuSbLLQVhuCXf2HMIKvYxGVh46eHRsCLYm2bsMK3j9GM/I+IDD+vX6kVtwFrBjt
         PrtF5B8GSMbtYB/OOmeDcQMi8k1Rc1O8i8pstaFbQCWUXHeMmY4ROVAjYc0u0X/NQ9XX
         IFf9HeEZZLqk7D5vKQBlzY6w9I3RdGHZzaPucu1DgjSj19brIlZVNkt/gsbjzvtWSdik
         dzkJ/uwwc97tP8Gevp26hiszmvA3LNPQ81InpUhVJqmgLJ7Y4z0N5RzTksC07Pf3orWi
         wdA0xawVl2LrxuE7+h0b+W7tW4JG2Lu8vRv6sjid4JPKUqb5jjbcMDV9d41ty8nB8wqG
         RLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WpdL8QZDYFesN5OhN9zP1zNf/fe8YGg+MSDVDDDuF8E=;
        b=Dle6+v+vesMWSrZyPwpQLfZk6AJCS5ixfeV62JEeCAbXQORBqFEBDlR7SZTgX7G5Hy
         EGqnwS3aRG+6DCxl989D7LhvOYQh+EE/AhGFhNkOfcBZBgxkV09PQ9ijQY6WAYDjVyVI
         K5NrNpWYaMNzh4gg0SOWomYXuJT2uOUVDo0kxBgMkj8VL/k1quEhKcWoJK0BwHnuu/lE
         /OH5fXkU5FVCC/RUoae5UBUM0MP0zoUFMWJSNj9vH8VYhNjB77TJNX5vbHAA+RqiFdMW
         nwGRYwEzey9xXWJsZInxCHOu4arX8so/btBT7dAjcsfE2NUe3s3uyhPXjhlt+TYopjHC
         9z1Q==
X-Gm-Message-State: ANhLgQ1bBzeWrrNbcWXKTqMDS6Cq9rKA5PmJ0yc28TkBWn6Jxz/accIx
        4+VDMkO20oTRZkaFNnEsdBINDA==
X-Google-Smtp-Source: ADFU+vsSMLVQqDIsb7tp0onhP30KYgXfJRWz4FVO5dR8Zc2AXVigVfBuTSoOmTORaJ1az/TtVDx4cw==
X-Received: by 2002:a05:620a:12d8:: with SMTP id e24mr1178035qkl.149.1583294104406;
        Tue, 03 Mar 2020 19:55:04 -0800 (PST)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 127sm6766852qkj.97.2020.03.03.19.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 19:55:03 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH -next] lib: disable KCSAN for XArray
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200304033329.GZ29971@bombadil.infradead.org>
Date:   Tue, 3 Mar 2020 22:55:02 -0500
Cc:     paulmck@kernel.org, elver@google.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <409B9444-73B7-4686-B0ED-892ECDECE462@lca.pw>
References: <20200304031551.1326-1-cai@lca.pw>
 <20200304033329.GZ29971@bombadil.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 3, 2020, at 10:33 PM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> On Tue, Mar 03, 2020 at 10:15:51PM -0500, Qian Cai wrote:
>> Functions like xas_find_marked(), xas_set_mark(), and =
xas_clear_mark()
>> could happen concurrently result in data races, but those operate =
only
>> on a single bit that are pretty much harmless. For example,
>=20
> Those aren't data races.  The writes are protected by a spinlock and =
the
> reads by the RCU read lock.  If the tool can't handle RCU protection,
> it's not going to be much use.
>=20

Maybe the commit log is a bit confusing if you did not look at the =
example closely
enough. It is actually one read and one write result in data races where =
one spin_lock()
and one rcu_read_lock()  can=E2=80=99t prevent that from happening. We =
also have,

[19522.548668][T39646] BUG: KCSAN: data-race in xas_clear_mark / =
xas_find_marked=20
[19522.583776][T39646] =20
[19522.593816][T39646] write to 0xffff9ffb56c5c238 of 8 bytes by =
interrupt on cpu 16:=20
[19522.628560][T39646]  xas_clear_mark+0x8e/0x1a0=20
[19522.648993][T39646]  __xa_clear_mark+0xe7/0x110=20
[19522.669367][T39646]  test_clear_page_writeback+0x3e9/0x712 =
[19522.694638][T39646]  end_page_writeback+0xaa/0x2b0=20
[19522.716850][T39646]  iomap_finish_ioend+0x213/0x3b0=20
[19522.740070][T39646]  iomap_writepage_end_bio+0x41/0x50=20
[19522.763835][T39646]  bio_endio+0x297/0x560=20
[19522.782608][T39646]  dec_pending+0x218/0x430 [dm_mod]=20
[19522.805389][T39646]  clone_endio+0xe4/0x2c0 [dm_mod]=20
[19522.828014][T39646]  bio_endio+0x297/0x560=20
[19522.846681][T39646]  blk_update_request+0x201/0x920=20
[19522.868929][T39646]  scsi_end_request+0x6b/0x4b0=20
[19522.889924][T39646]  scsi_io_completion+0xb7/0x7e0=20
[19522.911744][T39646]  scsi_finish_command+0x1ed/0x2a0=20
[19522.934411][T39646]  scsi_softirq_done+0x1c9/0x1d0=20
[19522.956357][T39646]  blk_done_softirq+0x181/0x1d0=20
[19522.977796][T39646]  __do_softirq+0xd9/0x57c=20
[19522.997300][T39646]  irq_exit+0xa2/0xc0=20
[19523.015469][T39646]  do_IRQ+0x87/0x180=20
[19523.032848][T39646]  ret_from_intr+0x0/0x42=20
[19523.054251][T39646]  delay_tsc+0x46/0x80=20
[19523.074662][T39646]  __const_udelay+0x3c/0x40=20
[19523.095161][T39646]  __udelay+0x10/0x20=20
[19523.113321][T39646]  kcsan_setup_watchpoint+0x1ec/0x3a0=20
[19523.137486][T39646]  __tsan_read8+0xf1/0x110=20
[19523.156973][T39646]  xas_find_marked+0xe9/0x750=20
[19523.177267][T39646]  find_get_pages_range_tag+0x1bf/0xa90=20
[19523.201945][T39646]  pagevec_lookup_range_tag+0x46/0x70=20
[19523.226242][T39646]  __filemap_fdatawait_range+0xbb/0x270=20
[19523.250977][T39646]  file_write_and_wait_range+0xe0/0x100=20
[19523.276077][T39646]  xfs_file_fsync+0xeb/0x450 [xfs]=20
[19523.298789][T39646]  vfs_fsync_range+0x71/0x110=20
[19523.320550][T39646]  xfs_file_buffered_aio_write+0x6cf/0x790 [xfs]=20
[19523.350421][T39646]  xfs_file_write_iter+0x232/0x2d0 [xfs]=20
[19523.375536][T39646]  do_iter_readv_writev+0x321/0x400=20
[19523.398811][T39646]  do_iter_write+0xdf/0x2b0=20
[19523.418758][T39646]  vfs_writev+0xe6/0x170=20
[19523.437516][T39646]  do_writev+0xa8/0x140=20
[19523.455844][T39646]  __x64_sys_writev+0x4e/0x60=20
[19523.476515][T39646]  do_syscall_64+0x91/0xb05=20
[19523.496441][T39646]  entry_SYSCALL_64_after_hwframe+0x49/0xbe=20
[19523.522946][T39646] =20
[19523.533125][T39646] read to 0xffff9ffb56c5c238 of 8 bytes by task =
39646 on cpu 16:=20
[19523.570758][T39646]  xas_find_marked+0xe9/0x750=20
[19523.594276][T39646]  find_get_pages_range_tag+0x1bf/0xa90=20
[19523.618877][T39646]  pagevec_lookup_range_tag+0x46/0x70=20
[19523.642674][T39646]  __filemap_fdatawait_range+0xbb/0x270=20
[19523.667295][T39646]  file_write_and_wait_range+0xe0/0x100=20
[19523.692394][T39646]  xfs_file_fsync+0xeb/0x450 [xfs]=20
[19523.715149][T39646]  vfs_fsync_range+0x71/0x110=20
[19523.736239][T39646]  xfs_file_buffered_aio_write+0x6cf/0x790 [xfs]=20
[19523.765345][T39646]  xfs_file_write_iter+0x232/0x2d0 [xfs]=20
[19523.791398][T39646]  do_iter_readv_writev+0x321/0x400=20
[19523.814709][T39646]  do_iter_write+0xdf/0x2b0=20
[19523.834576][T39646]  vfs_writev+0xe6/0x170=20
[19523.853486][T39646]  do_writev+0xa8/0x140=20
[19523.871952][T39646]  __x64_sys_writev+0x4e/0x60=20
[19523.893148][T39646]  do_syscall_64+0x91/0xb05=20
[19523.914075][T39646]  entry_SYSCALL_64_after_hwframe+0x49/0xbe=20


[19648.209937][T39683] BUG: KCSAN: data-race in find_get_pages_range_tag =
/ xas_set_mark=20
[19648.248321][T39683] =20
[19648.258683][T39683] write to 0xffffa001c3340238 of 8 bytes by task =
39682 on cpu 25:=20
[19648.295245][T39683]  xas_set_mark+0x8e/0x190=20
[19648.315514][T39683]  __test_set_page_writeback+0x5de/0x8c0=20
[19648.341697][T39683]  iomap_writepage_map+0x8c6/0xf90=20
[19648.364916][T39683]  iomap_do_writepage+0x12b/0x450=20
[19648.388367][T39683]  write_cache_pages+0x523/0xb20=20
[19648.410232][T39683]  iomap_writepages+0x47/0x80=20
[19648.431404][T39683]  xfs_vm_writepages+0xc7/0x100 [xfs]=20
[19648.455333][T39683]  do_writepages+0x5e/0x130=20
[19648.476105][T39683]  __filemap_fdatawrite_range+0x19e/0x1f0=20
[19648.502048][T39683]  file_write_and_wait_range+0xc0/0x100=20
[19648.527175][T39683]  xfs_file_fsync+0xeb/0x450 [xfs]=20
[19648.549886][T39683]  vfs_fsync_range+0x71/0x110=20
[19648.570508][T39683]  __x64_sys_msync+0x210/0x2a0=20
[19648.591742][T39683]  do_syscall_64+0x91/0xb05=20
[19648.612093][T39683]  entry_SYSCALL_64_after_hwframe+0x49/0xbe=20
[19648.638410][T39683] =20
[19648.648486][T39683] read to 0xffffa001c3340238 of 8 bytes by task =
39683 on cpu 26:=20
[19648.684048][T39683]  find_get_pages_range_tag+0x549/0xa90=20
xas_for_each_marked() =E2=80=94> xas_find_marked()
[19648.710117][T39683]  pagevec_lookup_range_tag+0x46/0x70=20
[19648.737531][T39683]  __filemap_fdatawait_range+0xbb/0x270=20
[19648.762541][T39683]  file_write_and_wait_range+0xe0/0x100=20
[19648.787436][T39683]  xfs_file_fsync+0xeb/0x450 [xfs]=20
[19648.810136][T39683]  vfs_fsync_range+0x71/0x110=20
[19648.830827][T39683]  __x64_sys_msync+0x210/0x2a0=20
[19648.852022][T39683]  do_syscall_64+0x91/0xb05=20
[19648.871962][T39683]  entry_SYSCALL_64_after_hwframe+0x49/0xbe=20
[19648.899496][T39683] =20
[19648.909496][T39683] 1 lock held by doio/39683:=20
[19648.930880][T39683]  #0: ffffffffaf286cc0 (rcu_read_lock){....}, at: =
find_get_pages_range_tag+0x10f/0xa90=20
[19648.976219][T39683] irq event stamp: 2463763=20
[19648.996565][T39683] hardirqs last  enabled at (2463763): =
[<ffffffffade03ec2>] trace_hardirqs_on_thunk+0x1a/0x1c=20
[19649.043090][T39683] hardirqs last disabled at (2463761): =
[<ffffffffaec002e7>] __do_softirq+0x2e7/0x57c=20
[19649.087414][T39683] softirqs last  enabled at (2463762): =
[<ffffffffaec0034c>] __do_softirq+0x34c/0x57c=20
[19649.129838][T39683] softirqs last disabled at (2463635): =
[<ffffffffadec69f2>] irq_exit+0xa2/0xc0


