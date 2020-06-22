Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2237C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DC120738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592869657;
	bh=zAwSWQ8OvKxObFHvQv87JN2fQxHGoOpqfEKWX5QSxfA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=sm5+QBz3ALusW+cuWqZZlOvjRLaLIEWsE0VcYTay4/xIYKl9EuRsycN7hbBrlmPJt
	 mb1H621buXRFGGtfXkWA5znV+T2tl2P9AL0m/53rFVOz19Iq0vO/uZg/GcbGZVp/Ri
	 quDkyUma/hMsj+53HqFsyi0jnLOdGMVtzm278HK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgFVXrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:47:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46697 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbgFVXre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:47:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id n2so8283031pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 16:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JTvITH8zv2UiirsD4c1fgFQNvQdvFMxIvcN0BCe53iI=;
        b=etokx5WlVlTFgmUrw5dhPu8rM2K4Wy3oMC1e3d7mt89IxscoWmX1V5gbTxujt9z+bR
         k4tfyLQSpaThdzwJnGaKSXJLX9I3I7i81eWBIl6FlHh4GDLQfY1xHv6rg8jSnbgE0FBv
         BuRv1mqteRqCEzpWfR9NvWMfAIG4SpG378ml/xpkGHJFP375TroMl5dQjqyMzEXtkIXx
         WCop+dtrDraYTy8sWvJ3ZiEEsLF43sQfNndDqh3HjqvQc71+M3kh2KVXfPyqMDkneorf
         BQwiUj3pZRCKWQOLke00JrbOLDRgBP/4Tk/j7zcrSITmBboCVwAMhlwsJfQhB0ofe3Lm
         BN0g==
X-Gm-Message-State: AOAM5332USLgQlojlii/xnf/yBGT/fOIrjGT6iiCLU+g9XlIHVGpHMc9
        iZXpR3gAouyPgJsaYmFWjnXv0Q==
X-Google-Smtp-Source: ABdhPJx72Pm6LsNC4fLdGwlzl8iFtNOBSmeItFZY56V7VPMWLT75rU04HboqVu4maibgIS7/Fxkz1A==
X-Received: by 2002:a17:902:ee12:: with SMTP id z18mr21870343plb.211.1592869653523;
        Mon, 22 Jun 2020 16:47:33 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id n189sm15178382pfn.108.2020.06.22.16.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 16:47:32 -0700 (PDT)
Subject: Re: [PATCH v2 00/11] KVM: Support guest MAXPHYADDR < host MAXPHYADDR
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Mohammed Gamal <mgamal@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, babu.moger@amd.com
References: <20200619153925.79106-1-mgamal@redhat.com>
 <5a52fd65-e1b2-ca87-e923-1d5ac167cfb9@amd.com>
 <52295811-f78a-46c5-ff9e-23709ba95a3d@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <2bcdb1cb-c0c5-5447-eed5-6fb094ae7f19@kernel.org>
Date:   Mon, 22 Jun 2020 16:47:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <52295811-f78a-46c5-ff9e-23709ba95a3d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/20 4:07 PM, Paolo Bonzini wrote:
> On 19/06/20 23:52, Tom Lendacky wrote:
>>> A more subtle issue is when the host MAXPHYADDR is larger than that
>>> of the guest. Page faults caused by reserved bits on the guest won't
>>> cause an EPT violation/NPF and hence we also check guest MAXPHYADDR
>>> and add PFERR_RSVD_MASK error code to the page fault if needed.
>>
>> I'm probably missing something here, but I'm confused by this
>> statement. Is this for a case where a page has been marked not
>> present and the guest has also set what it believes are reserved
>> bits? Then when the page is accessed, the guest sees a page fault
>> without the error code for reserved bits?
> 
> No, for non-present page there is no issue because there are no reserved
> bits in that case.  If the page is present and no reserved bits are set
> according to the host, however, there are two cases to consider:
> 
> - if the page is not accessible to the guest according to the
> permissions in the page table, it will cause a #PF.  We need to trap it
> and change the error code into P|RSVD if the guest physical address has
> any guest-reserved bits.

You say "we need to trap it".  I think this should have a clear
justification for exactly what this accomplishes and how it benefits
what real-world guests.  The performance implications and the exact
condition under which they apply should IMO be clearly documented in
Documentation/, in the code, or, at the very least, in the changelog.  I
don't see such docs right now.

As I understand it, the problematic case is where a guest OS
intentionally creates a present PTE with reserved bits set.  (I believe
that Xen does this.  Linux does not.)  For a guest to actually be
functional in this case, the guest needs to make sure that it is not
setting bits that are not, in fact, reserved on the CPU.  This means the
guest needs to check MAXPHYADDR and do something different on different
CPUs.

Do such guests exist?  As far as I know, Xen is busted on systems with
unusually large MAXPHYADDR regardless of any virtualization issues, so,
at best, this series would make Xen, running as a KVM guest, work better
on new hardware than it does running bare metal on that hardware.  This
seems like an insufficient justification for a performance-eating series
like this.

And, unless I've misunderstood, this will eat performance quite badly.
Linux guests [0] (and probably many other guests), in quite a few
workloads, is fairly sensitive to the performance of ordinary
write-protect or not-present faults.  Promoting these to VM exits
because you
want to check for bits above the guest's MAXPHYADDR is going to hurt.

(Also, I'm confused.  Wouldn't faults like this be EPT/NPT violations,
not page faults?)

--Andy


[0] From rather out-of-date memory, Linux doesn't make as much use as
one might expect of the A bit.  Instead it uses minor faults.  Ouch.
