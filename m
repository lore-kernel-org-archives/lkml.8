Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E13C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7910320775
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZxxZKE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgCSQY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:24:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:30380 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727577AbgCSQY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584635096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6aiYGJqqYB7OtONFqTHz/q1w4j91YXMiUtw0onvEckc=;
        b=bZxxZKE+XPUPlRvl49jgIEt7elMZUH2gYJczfkZ8EoIoxfSeJIV7xu7tEVScolFtOz+hxK
        3E4LM2PxEpNnV9wjsYWmhf99fTFGrnz2j08xmHeam2Wm50jhww7DfLW7KYEyd9BC0lf6QY
        NXGpSZ9P0fu2yhT4K1+8Xw6GvYlKGdM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-H1sRllfiPRyXL03huG8-6Q-1; Thu, 19 Mar 2020 12:24:54 -0400
X-MC-Unique: H1sRllfiPRyXL03huG8-6Q-1
Received: by mail-wr1-f70.google.com with SMTP id k11so1277744wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 09:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6aiYGJqqYB7OtONFqTHz/q1w4j91YXMiUtw0onvEckc=;
        b=F5fS42NmRQr/SFSD4KiqxXv+hANcn9Ffsj+d2SukGlTKqIMB8JN7S66HQeelyt5ods
         Ubz8anhYVkbhJVMflMFPTmaT4WdREz+QvL537iBZbdZt7teuK4o4+aMmRlYWgcEE17rg
         B0Qghshuoj9gPq/jPAKERw1jJL+OgiGUnAbHgTOq9XNRDihyqZVgLMjyD1WodObdfHuw
         IRBGttNV2ysD1ja7L+u62LiRIcSYnlRehby4EzVihpORTOOBgKTQpdMf7D9lwXcQxKa3
         5PwlmGC2QZUmByPX+eJ6YKBabxrMvTpfGIOn9+v81x8ruHSXMlF/az/QssOHArpVklhu
         w6gA==
X-Gm-Message-State: ANhLgQ0P1qeFNYklduKGzqr9Fh+Bl/BelEIacBzG4od8p5LsWnpX/RM1
        DIn07Fv4VKbVb21J4/dIllc2mH82zYd8eM1dfPZ0/CTPevCc5fduoZ1zGSEppqWrlJbYahJD9mg
        Ux3wFio9RK7Qx6jw38mh/bRml
X-Received: by 2002:a5d:6908:: with SMTP id t8mr5390428wru.92.1584635093307;
        Thu, 19 Mar 2020 09:24:53 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtpBLc0nNDpfhkz/RUZ3FdCM6IUwSnyDZFcyfbsP0oZyHeZZFgMBwi09mfhvTHafLFEzBbiIQ==
X-Received: by 2002:a5d:6908:: with SMTP id t8mr5390399wru.92.1584635093053;
        Thu, 19 Mar 2020 09:24:53 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id m10sm3724369wmc.24.2020.03.19.09.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 09:24:52 -0700 (PDT)
Subject: Re: [PATCH 00/12] SEV Live Migration Patchset.
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Rientjes <rientjes@google.com>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <cover.1581555616.git.ashish.kalra@amd.com>
 <CALCETrXE9cWd3TbBZMsAwmSwWpDYFsicLZ=amHLWsvE0burQSw@mail.gmail.com>
 <20200213230916.GB8784@ashkalra_ubuntu_server>
 <CALCETrUQBsof3fMf-Dj7RDJJ9GDdVGNOML_ZyeSmJtcp_LhdPQ@mail.gmail.com>
 <20200217194959.GA14833@ashkalra_ubuntu_server>
 <101d137c-724a-2b79-f865-e7af8135ca86@redhat.com>
 <20200319161831.GA10038@ashkalra_ubuntu_server>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bffda827-2d9c-a6ae-f811-c6941fe03530@redhat.com>
Date:   Thu, 19 Mar 2020 17:24:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319161831.GA10038@ashkalra_ubuntu_server>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/20 17:18, Ashish Kalra wrote:
>>> For the second case, we have been discussing this internally,
>>> and one option is to extend the KVM capabilites/feature bits to check for this ?
>> You could extend the hypercall to completely block live migration (e.g.
>> a0=a1=~0, a2=0 to unblock or 1 to block).  The KVM_GET_PAGE_ENC_BITMAP
>> ioctl can also return the blocked/unblocked state.
>>
> Currently i have added a new KVM para feature
> "KVM_FEATURE_SEV_LIVE_MIGRATION" to indicate host support for the SEV
> live migration feature and a custom KVM MSR "MSR_KVM_SEV_LIVE_MIG_EN"
> for the guest to enable SEV live migration. The MSR also has other
> flags for future SEV live migration extensions.

Ok, that would be fine too.  Thanks!

Paolo

