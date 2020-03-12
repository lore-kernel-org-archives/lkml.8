Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E30C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E87820663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeMbBp12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgCLO5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:57:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56384 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727241AbgCLO5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584025066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9BiE/HHtrwYLPDrEYfMy85B46eYpg1Qlp9PySkGqkw=;
        b=eeMbBp12T7pIGQBtRO+AQlKzJehT6KOjtYHBTTQa3ePG5YKwMMfZpnEMTcjgMFeZxNE6no
        hgpY6KSn6VRsf7ACuCKmAK24jw/idlOs8Hzki3dyD7KlVCsD6kNco/3VQBK+joJJqBVBF8
        /25eBpcd4Z1yHZ7/3lKG3w6Jjz8yH8w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-zmg3j9h2PHyF1X7J4fnFmw-1; Thu, 12 Mar 2020 10:57:44 -0400
X-MC-Unique: zmg3j9h2PHyF1X7J4fnFmw-1
Received: by mail-wr1-f71.google.com with SMTP id z13so2741887wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y9BiE/HHtrwYLPDrEYfMy85B46eYpg1Qlp9PySkGqkw=;
        b=KCip+uDmGtQMuMsoCHSpfneDPpFVOhDGVIMuWl5LAJXgayuG5CAENvb3AcEqXMXC1N
         CMw6kqjbaI0WMq/04sW2DrRTf/IRFRdfIUrTrEJ0GrlG4glx9UBNqTZXV/Ek2VfZ383s
         +7eqGt1/P49KT7/OwnY2pzIvuRDJOZw4NOugIHDH5fALkcn0DcU05tRKfoGS1ZaNJ/3e
         0ULitDt0lncER9+8aLcarqtxIlqqH5z7dd3x9RrMqAD0RzqCAdoplfDzCL/7EvBJ1FO+
         fBnK0EQ+cFs5JjX+YvFteHXPMW3d7pkXsNL45nuo+SIbghXZkGDR8Pj3DOa8UnF2qOo+
         2Tgw==
X-Gm-Message-State: ANhLgQ3g3F0JimUhCd05PvEN+GiJQJaad6i7i5HzyefhQw+VoH/ndCvR
        ZHUXd8el/sn26M2CjOtmME0CuEzN5Cd0GVU1cZO+4R2Xh7BMIjCbVI+kL5663brA/QsbSqiLS9G
        5tMd36SAx2B3voj6K5qokfzSK
X-Received: by 2002:adf:e5d2:: with SMTP id a18mr3697470wrn.334.1584025063153;
        Thu, 12 Mar 2020 07:57:43 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vutKOKjAYrJX87oG5W63GUQb+emBV4G27C2zp5/6DHbAwJ9kGIiD1GDP0LQWNnKHvjJ4ObyCg==
X-Received: by 2002:adf:e5d2:: with SMTP id a18mr3697448wrn.334.1584025062935;
        Thu, 12 Mar 2020 07:57:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id d1sm13161470wrw.52.2020.03.12.07.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:57:42 -0700 (PDT)
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
 <899f366e-385d-bafa-9051-4e93dc9ba321@redhat.com>
 <20200312125032.GC15619@zn.tnic>
 <8af51d90-27fa-6d2a-2159-ef0a9089453a@redhat.com>
 <20200312142553.GF15619@zn.tnic>
 <94c6f903-7dca-503e-aca7-1ee4641bcdac@redhat.com>
 <20200312144922.GG15619@zn.tnic>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <69daa857-4dd0-730d-cebd-45c37cc5f66a@redhat.com>
Date:   Thu, 12 Mar 2020 15:57:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312144922.GG15619@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/12/20 3:49 PM, Borislav Petkov wrote:
> On Thu, Mar 12, 2020 at 03:38:22PM +0100, Hans de Goede wrote:
>> So I've send out 2 versions, not 5 not 10, but only 2 versions in
>> the past 2 days and you start complaining about me rushing this and
>> not fixing it properly, to me that does not come across positive.
> 
> Maybe there's a misunderstanding: when you send a patchset which is not
> marked RFC, I read this, as, this patchset is ready for application. But
> then the 0day bot catches build errors which means, not ready yet.
> 
> And I believe you expected for the 0day bot to test the patches first
> and they should then to be considered for application. Yes, no?

I guess this is the root cause of our misunderstanding. I certainly
did not expect the 0day bot to catch any issues, because I did not
expect there to be any pre-existing issues.

As said I wrote the patch because my sha256 changes from a while ago
broke the purgatory because of introducing a missing symbol. My intend
was to avoid a repeat of that regression by catching issues like this
during build time.  I did not expect there to already be (more)
such issues in the existing code; and I certainly did not expect
there to be more then 1 such issue.

So having to do v4 to fix one pre-existing issue was a surprise.
Having to then do a v5 because there was more then one pre-existing
issue was an even bigger surprise.

I understand that you are pushing-back against people using 0day bot
to find bugs for them and that was never my goal.

OTOH I don't appreciate getting push-back because if my change
exposing *pre*-existing bugs. I am not responsible for those
pre-existing bugs and as such I also do not feel responsible for
0day bot triggering on them. Are the 0day bot reports and the need
to rev the patch-set and post a new version annoying? Yes they are;
however they are not my fault.

Regards,

Hans

