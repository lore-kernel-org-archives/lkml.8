Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75C0C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 12:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA52206D3
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 12:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlhE1lZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgEIMxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 08:53:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30703 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbgEIMxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 08:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589028815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eGJhJOsthSw8sWZIpmRm98+CYNbZN+vO8DLKnqyl6n0=;
        b=KlhE1lZPYZIMsV/3pgwApSaw2J6Cy9rbWizG3nhDkVgLZSHhngdPBS7pTF0CxG2nS6n3tQ
        hU2II3RLoghgOpNizl4XVGrLmHaudXF7VKHB2ZSnviiww4FiWfJT5LUZYiNv8haol8S9su
        xTJg87dFg01YwvkS8g8Eha+x7OaZGVI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-8dhG-lcaNQqk4UQbHpsyOw-1; Sat, 09 May 2020 08:53:33 -0400
X-MC-Unique: 8dhG-lcaNQqk4UQbHpsyOw-1
Received: by mail-wr1-f69.google.com with SMTP id z8so2340943wrp.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 05:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eGJhJOsthSw8sWZIpmRm98+CYNbZN+vO8DLKnqyl6n0=;
        b=T1V02JPpUAwdF8s8VkwgJIp7iXpKjIwZNfJNgd4k3/WIYLrF7J6bPu30Orfw0I0Ddw
         NbX9hsHzSiFCSLQEjxgFAf7cP7BWOyPdl0Pcw+hD7M1pHD74njshI3oOt6zyjFcVCDvI
         yDDJtF2ZAmelckHORQsk35ntZwDFDTG7YA+4tRGg2p7lv/dGTSStVKlmEhTwpQdL5uXe
         7QwFV4/Q8X0ugShMTjdbRmsL6Mx8r8cc3H7laHLysOPZsZD8Y54vgH3sauV0AnSDZfGk
         8EP9q+7zpXXha3hPXwYfZWxm/PILf98kaHTbGZ8ZTSVfroQUNR3KgQ0ruDXT1YaYNJgx
         Puaw==
X-Gm-Message-State: AGi0PuYWK8vkXwWnppLrHrIG/E1TohSLGZQT6LxJ7RJLZ4gfTkGrZvq0
        MHvYlb20zyIUjMIUNkc8JmekxCD8cjsIRXaNlPDbNxklGdRuF4c88A9mwU+25pu5UY4R/Lk3FJh
        PkusHHrWxoHTi74n8xVwWzXQw
X-Received: by 2002:a5d:4284:: with SMTP id k4mr8281038wrq.284.1589028812170;
        Sat, 09 May 2020 05:53:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ9vO9iz7HL9NNeB7tLQTqkssfs8IAeaFLPHIYgHO4nuauOKJd9YWiEWo0PpQCuQgNgD6n43w==
X-Received: by 2002:a5d:4284:: with SMTP id k4mr8281020wrq.284.1589028811931;
        Sat, 09 May 2020 05:53:31 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id w13sm7850488wrm.28.2020.05.09.05.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 05:53:31 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: asus-nb-wmi: Do not load on Asus T100TA and
 T200TA
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200422220559.99726-1-hdegoede@redhat.com>
 <bcb4d40a-8971-22d6-959b-14b2d329cfd4@redhat.com>
 <CAHp75Vceqb4tpM_G7hcg2RWF6Cp+P61NiiYfQsf9tr8vtFJGHg@mail.gmail.com>
 <CAHp75VdTuwyJuGsAR4NwJm302Va+68dDdtC-kn3581asg-onvQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5a6d2656-ee4c-c3a8-03d3-197106b063f1@redhat.com>
Date:   Sat, 9 May 2020 14:53:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdTuwyJuGsAR4NwJm302Va+68dDdtC-kn3581asg-onvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/9/20 2:23 PM, Andy Shevchenko wrote:
> On Fri, May 8, 2020 at 11:56 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>
>> On Fri, May 8, 2020 at 10:54 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>> On 4/23/20 12:05 AM, Hans de Goede wrote:
>>
>>> Andy, Darren, I see that you have already added this to the for-next
>>> branch of linux-platform-drivers-x86. I'm not sure what your vision
>>> on forced pushed there is. If forced pushes are ok, please drop this
>>> patch. If not let me know and I will send out a revert.
>>
>> Forced pushes are not okay, but we have exceptions in some cases.
>> It would be done here, but there are complications, i.e. we have
>> already immutable branch merged from MFD. Of course, I would remerge
>> it again, but I think we better not to do this right now, so, revert
>> seems a less painful in this case. Or, if you have already done
>> something better, than keep it as follow up improvement rather than
>> pure revert.

Ok, doing the revert is fine with me, I've prepped it and I will
send it out right away.

> Oops, it seems I was quick enough to push this to v5.7-rc4. So, please
> send revert!

Note the commit does not break anything; it even works as advertised
to fix the camera LED being stuck in on state at boot on the Asus T100TA
and Asus T200TA.

The problem is that I'm working on making various 2-in-1s report their
tablet-mode state (SW_TABLET_MODE) to userspace; and I've found that
these 2 Asus models (and other Asus models) report this through WMI.

So the blacklisting of these 2 models inside asus-nb-wmi needs to be
dropped to make the SW_TABLET_MODE reporting work once I have added that
to the asus-nb-wmi driver, so the revert is to prepare for that it
does not fix any regression, since the current version of asus-nb-wmi
does not handle SW_TABLET_MODE.

So there is no need to rush the revert upstream, it can go to 5.8 together
with the asus-nb-wmi changes to add SW_TABLET_MODE support.

The reason I was asking to drop the commit was because I came to the
conclusion that in the end the blacklist is not what we want. But for
now having the blacklist is fine.

Regards,

Hans

