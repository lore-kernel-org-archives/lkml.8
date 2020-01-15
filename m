Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37468C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB4E214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgAOBUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:20:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:55773 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbgAOBUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 20:20:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 17:20:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; 
   d="scan'208";a="225800371"
Received: from unknown (HELO localhost) ([10.239.159.54])
  by orsmga006.jf.intel.com with ESMTP; 14 Jan 2020 17:20:46 -0800
Date:   Wed, 15 Jan 2020 09:20:55 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Li Xinhai <lixinhai.lxh@gmail.com>
Cc:     khlebnikov <khlebnikov@yandex-team.ru>,
        "richardw.yang" <richardw.yang@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        akpm <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@redhat.com>,
        "kirill.shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 1/2] mm/rmap: fix and simplify reusing mergeable
 anon_vma as parent when fork
Message-ID: <20200115012055.GC4916@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <b8269278-85b5-9fd2-9bce-6defffcad6e8@yandex-team.ru>
 <20200110023029.GB16823@richard>
 <20200110112357351531132@gmail.com>
 <20200110053442.GA27846@richard>
 <d89587b7-f59f-3897-968b-969b946a9e8a@yandex-team.ru>
 <20200111223820.GA15506@richard>
 <a6a7bb3b-434e-277c-694f-d5a18e629d2c@yandex-team.ru>
 <20200113003343.GA27210@richard>
 <1cf002fa-a3cb-bcef-57dc-ac9c09dcf2eb@yandex-team.ru>
 <2020011422424965556826@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2020011422424965556826@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 10:42:52PM +0800, Li Xinhai wrote:
>On 2020-01-13 at 19:07 Konstantin Khlebnikov wrote:
>
>>
>>Because I want to keep both heuristics.
>>This seems most sane way of interaction between them.
>>
>>Unfortunately even this patch is slightly broken.
>>Condition prev->anon_vma->parent == pvma->anon_vma doesn't guarantee that
>>prev vma has the same set of anon-vmas like current vma.
>>I.e. anon_vma_clone(vma, prev) might be not enough for keeping connectivity. 
>
>New patch is required?

My suggestion is separate the fix and new approach instead of mess them into
one patch.

>It is necessary to call anon_vma_clone(vma, pvma) to link all anon_vma which
>currently linked by pvma, then link the prev->anon_vma to vma. By this way,
>connectivity of vma should be maintained, right?
>
>>Building such case isn't trivial job but I see nothing that could prevent it.
>>
>

-- 
Wei Yang
Help you, Help me
