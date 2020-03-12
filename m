Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A8AC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827EA20674
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfPuEV8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCLL6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:58:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57308 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726302AbgCLL6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584014309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xTE5YYj4UuQcjZypf7HbBJSXHoyXdnzMaxOvgqYzANU=;
        b=KfPuEV8AB9CbhO8ao/Durk5J7L6tUhQSJBWNAdSvy5YR06obdn+SOVSVz+Y03O7i1IXApD
        X3ugskfAAy4hViij8OInkgfw1pFILIf0mo+pYX5cYZ566UQmwGSDfl83BqCerGFQaZ6IKD
        4YtjapsNOrqij/Sb6mGzg5wvv7uyLY4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-yM2evw7UMoK8vqV7eE_xGg-1; Thu, 12 Mar 2020 07:58:27 -0400
X-MC-Unique: yM2evw7UMoK8vqV7eE_xGg-1
Received: by mail-wr1-f70.google.com with SMTP id u18so2462903wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 04:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xTE5YYj4UuQcjZypf7HbBJSXHoyXdnzMaxOvgqYzANU=;
        b=hLTDahZ3VqLbuBmQy32U4s48hXdUnhShhlg+1kmgZvOLnfo7S2Phc0ReTnHwFg2QO1
         E35BHLGLLkQTkxDDwLYW9ANk7GiCWYTQquBVw5wDe9+dip97koNT1hHv7pgHg5/pKRNE
         M+q0i14L6KOqe+IcLpZODotrIgA2FaOdn3/5dZAuYjs0t8iuMC/lbmDTJcAahLaMHzEO
         Bpx+eyNP1LiZo8TeiDfposvomNu187tEFKgRNNSE/jdnhz4q18sfUXl2fXbxnSL1hfcL
         0btt5RXw9Z0le83TVFXrrsGLgnujJsp+p5n8OiY0M6HSuUdAZ0PX/hNg/cYivxzeh7oa
         EnJA==
X-Gm-Message-State: ANhLgQ35kRaIvU1NgbpKH6u/Ab8vmjuZGy0qmhLJrKFWjwl8xKK3RS8m
        G92q2PnFckcOysxeC7ZfSl9mwhszroR4JjPmPhTphz6CblD064lRqgHWt4jHLgDm7GA8FuES9dr
        6w291/1jhg4qn2Wx+hk6DFSi9
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr11031056wrq.10.1584014306058;
        Thu, 12 Mar 2020 04:58:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuKfMGhPJGqf2mrRGb0wxM2B67HtQptPh2vvKsNyok6ruathSvwL0t+sFr8I0N2S3/imPfLWg==
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr11031028wrq.10.1584014305825;
        Thu, 12 Mar 2020 04:58:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id g7sm75259131wrq.21.2020.03.12.04.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 04:58:25 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20200311214601.18141-1-hdegoede@redhat.com>
 <20200311214601.18141-3-hdegoede@redhat.com>
 <20200312001006.GA170175@rani.riverdale.lan>
 <3d58e77d-41e5-7927-fe84-4c058015e469@redhat.com>
 <20200312114225.GB15619@zn.tnic>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <899f366e-385d-bafa-9051-4e93dc9ba321@redhat.com>
Date:   Thu, 12 Mar 2020 12:58:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312114225.GB15619@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/12/20 12:42 PM, Borislav Petkov wrote:
> On Thu, Mar 12, 2020 at 12:31:39PM +0100, Hans de Goede wrote:
>> I will send out a v5 of my patch-set changing the first patch to
>> also fix the new issue the kbuild test robot has found. I'm going
>> to leave this patch as is. If you prefer replacing the second patch
>> in the set (this patch) with your solution then that is fine with me.
> 
> Can we please slow down here, select the best solution, test it properly
> - yes, kexec file-based syscall whatever which uses the purgatory -

My version of this patch has already been tested this way. It is
Arvind's alternative version which has not been tested yet.

> and be
> done with it once and for all instead of quickly shooting out patchsets
> which keep breaking some randconfigs?

For v5 I have synced the list of disabled trace/sanitize options with
the one from drivers/firmware/efi/libstub/Makefile so v5 should catch
all known cases of things breaking with some special randconfigs.

Also I would like to point out that:

1. Things are already broken, my patch just exposes the brokenness
of some configs, it is not actually breaking things (well it breaks
the build, changing a silent brokenness into an obvious one).

2. I send out the first version of this patch on 7 October 2019, it
has not seen any reaction until now. So I'm sending out new versions
quickly now that this issue is finally getting some attention...

Regards,

Hans

