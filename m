Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D64C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C134E206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4U8A6tI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389376AbgDNORz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:17:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47131 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389221AbgDNORq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586873864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QHCeqfyaSTGSDpETLFfXGP1uAtSb/Pgabn5X7MN5Pk=;
        b=P4U8A6tI8EwFQfn1hpmYUJ1yVciVxWLMKfcN99rOFuBzsWgPVg0AL6ADGHNxX1/q1lQKKG
        w1/UShY1959/VP3lK4LfclqBFJ4JthBBx266yJ+lug9vEAH0h9+84J7rAspNHvX2cI+qGo
        U6eYOMz1D/j5eQBd0/LKqyifbpPYrrI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-Jlm4Y5WyOaymaL1KWDTuAw-1; Tue, 14 Apr 2020 10:17:43 -0400
X-MC-Unique: Jlm4Y5WyOaymaL1KWDTuAw-1
Received: by mail-wm1-f72.google.com with SMTP id q5so2427276wmc.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5QHCeqfyaSTGSDpETLFfXGP1uAtSb/Pgabn5X7MN5Pk=;
        b=A/W1Ya9eh25KI/yfV7f2a0uvBtRQVTmyIm4xtFiGjZs1Rp0U7CgX4P7fDTZJDyTIgo
         YDtNlaVzeAvGB+xgYyWwpzCQ3+ZI7mdXN1XNLmOO0q7KtOz3UjQnoRnrPLHlN4QK8bln
         HZbQgThX/DNc8xtkLI44bzcJ6nfOtlvhrW3BEx27qsSZXbgLMaFUR2S2Gr2k9xdrtvK8
         00xrk2zkXpSYOGmki8FRLmR5B4MMMc9LSMNOL5Smsa2gX5xcqt3tfBYaFM5iwIfb37jM
         MDbKOnHfEBNK2fI5+wgjJ9ZzMJzJxaPv+hcKjaUFfwwTB1b0A6iFaC/HhtBLdUUw5kUw
         rx/w==
X-Gm-Message-State: AGi0Pua3ARON/sXQrxvpjFSFcbfsuHakXtAvS+Nir5wJSGGzc+F5VKdZ
        XyW0WjSXseogoKuz+491ku8WgvgajSjK9+cU1oZx88+2G4S/f+cw0WzVqlHeE/38mvYscINwj7g
        /MDm/sBGDlDlK3fAPDLmgvyJA
X-Received: by 2002:adf:fdc6:: with SMTP id i6mr24657323wrs.252.1586873861747;
        Tue, 14 Apr 2020 07:17:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypI+UgxXH7zNgeu1lrXmzwADbPtn6APUxuWMZS+2tZLsQnFrsp36SqmAnx3rOKiAgXZepSgYPw==
X-Received: by 2002:adf:fdc6:: with SMTP id i6mr24657307wrs.252.1586873861531;
        Tue, 14 Apr 2020 07:17:41 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id a10sm19252822wrm.87.2020.04.14.07.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 07:17:40 -0700 (PDT)
Subject: Re: [RFC][PATCH 00/36] objtool: Make recordmcount a subcommand
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Miroslav Benes <mbenes@suse.cz>
References: <cover.1586468801.git.mhelsley@vmware.com>
 <3a3f70df-07b0-91d9-33e1-e997e72b0c5c@redhat.com>
 <20200414093506.7b91bbbb@gandalf.local.home>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <064f41bd-0dfe-e875-df7c-214184c29fa7@redhat.com>
Date:   Tue, 14 Apr 2020 15:17:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414093506.7b91bbbb@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/20 2:35 PM, Steven Rostedt wrote:
> On Tue, 14 Apr 2020 08:24:15 +0100
> Julien Thierry <jthierry@redhat.com> wrote:
> 
>> If all you need from objtool it the elf parsing code, wouldn't it make
>> more sense to move that out of objtool, as a utility library that both
>> objtool and recordmcount could use (and perhaps other tools in the future?)
>>
>> In patch 3 you seem to mention that other tools already have their own
>> code to parse elf. So instead of converting everything as an objtool
>> subcommand, maybe just have the library with the required functionality.
>>
>> Any opinions on the above? What do people prefer?
> 
> I think we discussed this before (and originally that was the plan), but I
> believe one of the goals for bringing recordmcount into objtool is to speed
> up the processing. Instead of having to read the elf sections for each use
> case, we do it once, and then execute all the necessary operations for that
> build.
> 
> If we just have a elf parsing library, then each object file is going to
> have that read redundantly for each operation that is done on it.
> 
> I was hoping to have objtool handle all the operations needed that required
> reading elf headers.
> 

That makes sense, however, having each operation as an objtool 
subcommand doesn't solve that issue, right? Each invocation of objtool 
will re-read the elf object.

I guess having all the relevant code in objtool as subcommand would be a 
first step towards that goal.

> But if that's not what objtool maintainers want, then we can certainly go
> back to looking at pulling out the elf headers, and have each tool be a
> standalone again.
> 

I'm no maintainer nor know their feeling about this and I haven't been 
part of the initial discussion. My main concern was about the approach 
of moving existing subcommand code to arch specific folders.

Thanks for the explanations.

Cheers,

-- 
Julien Thierry

