Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09277C33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5F02084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEhY48/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgAMIs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:48:27 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45311 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgAMIs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:48:27 -0500
Received: by mail-oi1-f196.google.com with SMTP id n16so7491369oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 00:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WZ/Vp5J75l/Z0Fz+dAhAJFvPAQAZ19P0lPgX+P8DE2c=;
        b=kEhY48/M0ggWwX4MEp67wWDacjjM2wtpVF6VdfR+QTa89pYS1Ttsf2zhsO8+rAUU6z
         nbOC/tzJ7vvPxgnf9hcmvu4/CpYXaqm+jest6X7tewjKCfUhoIsPnKpvMaAYphzImzb3
         QMSQYIkrXk95BmJ1me8KmozT7h4bu25C/qD6qjVtdBIz3J8fCDJMnquBwx0dPFkEUi49
         LAkoO8wjIPqvgDTcDa6SCty/lMoV7Z9BZ64d/h8EexOUrv9unhFGEg8rxKLv3T+CUoIl
         Lxa/6cd0OwlV5Cqciuy5rYZXpeQu45NJicfJBAplLaiYsZL97KT4EWcZOdy52FmI2ydI
         rMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WZ/Vp5J75l/Z0Fz+dAhAJFvPAQAZ19P0lPgX+P8DE2c=;
        b=NL4zVs/gBUgZ8pmzXrLEkuHjVTQFrMXSk660mwR2L8FZIxfmsCf2yyxUY5LF1Nxbx/
         8wF6c3FYyVMoZcLP0FuTjMtltxxJ5XFnvxUaEC7Yz/667NLBv+Ii8lIgKNmXkb/suyTz
         sFXcqlhCu10NtyNZUUW/cticbgcT6SM/K2OLtizaAiCd852JF5lQTSukoLtHHGW6bhTr
         amw9PvC+Ua8g6mi0io5dSN6cTqz3nufz7ajIUdYvPPu0FJJQrIEe27Ly1yf5VFd6TeWp
         0NlR6CFsSvTKlGeCBk+sJ4j/iDY/MnjhOcOzEMhV2jDFZa0mLKKRxUQJQqZJyofW4r7W
         8qSw==
X-Gm-Message-State: APjAAAWG7gNicntiWCpfte7ECh571Sv39oEskr6bu7dC3HGjDRWxwxjw
        pOl1dkAvE37Ju+RMoA/HLgcjrv+x2x4=
X-Google-Smtp-Source: APXvYqxMQhw3Z5zgpWJ+2DIL+uOUDya8Vn39qFQYSWRl1BI5LUX2DqO/ktpcDtBkOE16BMvbiG3qCA==
X-Received: by 2002:aca:1a10:: with SMTP id a16mr12108681oia.9.1578905306366;
        Mon, 13 Jan 2020 00:48:26 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h9sm3286549oie.53.2020.01.13.00.48.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jan 2020 00:48:25 -0800 (PST)
Date:   Mon, 13 Jan 2020 00:48:12 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     hannes@cmpxchg.org, Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, tj@kernel.org,
        hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, shakeelb@google.com
Subject: Re: [PATCH v7 00/10] per lruvec lru_lock for memcg
In-Reply-To: <d2efad94-750b-3298-8859-84bccc6ecf06@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2001130032170.1103@eggly.anvils>
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com> <20191231150514.61c2b8c8354320f09b09f377@linux-foundation.org> <944f0f6a-466a-7ce3-524c-f6db86fd0891@linux.alibaba.com> <d2efad94-750b-3298-8859-84bccc6ecf06@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-817818044-1578905305=:1103"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-817818044-1578905305=:1103
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 10 Jan 2020, Alex Shi wrote:
> =E5=9C=A8 2020/1/2 =E4=B8=8B=E5=8D=886:21, Alex Shi =E5=86=99=E9=81=93:
> > =E5=9C=A8 2020/1/1 =E4=B8=8A=E5=8D=887:05, Andrew Morton =E5=86=99=E9=
=81=93:
> >> On Wed, 25 Dec 2019 17:04:16 +0800 Alex Shi <alex.shi@linux.alibaba.co=
m> wrote:
> >>
> >>> This patchset move lru_lock into lruvec, give a lru_lock for each of
> >>> lruvec, thus bring a lru_lock for each of memcg per node.
> >>
> >> I see that there has been plenty of feedback on previous versions, but
> >> no acked/reviewed tags as yet.
> >>
> >> I think I'll take a pass for now, see what the audience feedback looks
> >> like ;)
> >>
> >=20
>=20
> Hi Johannes,
>=20
> Any comments of this version? :)

I (Hugh) tried to test it on v5.5-rc5, but did not get very far at all -
perhaps because my particular interest tends towards tmpfs and swap,
and swap always made trouble for lruvec lock - one of the reasons why
our patches were more complicated than you thought necessary.

Booted a smallish kernel in mem=3D700M with 1.5G of swap, with intention
of running small kernel builds in tmpfs and in ext4-on-loop-on-tmpfs
(losetup was the last command started but I doubt it played much part):

mount -t tmpfs -o size=3D470M tmpfs /tst
cp /dev/zero /tst
losetup /dev/loop0 /tst/zero

and kernel crashed on the

VM_BUG_ON_PAGE(lruvec_memcg(lruvec) !=3D page->mem_cgroup, page);
kernel BUG at mm/memcontrol.c:1268!
lock_page_lruvec_irqsave
relock_page_lruvec_irqsave
pagevec_lru_move_fn
__pagevec_lru_add
lru_add_drain_cpu
lru_add_drain
swap_cluster_readahead
shmem_swapin
shmem_swapin_page
shmem_getpage_gfp
shmem_getpage
shmem_write_begin
generic_perform_write
__generic_file_write_iter
generic_file_write_iter
new_sync_write
__vfs_write
vfs_write
ksys_write
__x86_sys_write
do_syscall_64

Hugh
--0-817818044-1578905305=:1103--
