Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F313C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5C020767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEjakqJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406585AbgDNHY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:24:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29898 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406564AbgDNHYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586849061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rj4R5XKngP+oYbnlTRrostFHY1+zdyWkTib4ZVvnlaA=;
        b=FEjakqJ6c3g0s4OvaURLpHYNyVG0WtnCZyRu8yxQh6yueSVR0USkbrBR/NIdWT1wClCmEa
        jXpX366kR43ul+kpELHcHgi4VSx1VWtCJlzZKYDz9T9yLPx1zRrc1c6m0qHxJCttwPARGP
        TycW6SkdEGjFC2lPbdkG1V1buirP2Zo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-n8vRV58VNkyHGjQsAn0rBA-1; Tue, 14 Apr 2020 03:24:18 -0400
X-MC-Unique: n8vRV58VNkyHGjQsAn0rBA-1
Received: by mail-wr1-f71.google.com with SMTP id v14so8237841wrq.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rj4R5XKngP+oYbnlTRrostFHY1+zdyWkTib4ZVvnlaA=;
        b=nwvryFTdQVP/3g+m8dxK2vWHVpAjqIYhWgLKGFDs19Btent/vcROo1wgmHvqElKuXv
         Q25HiKC+ijNAgFQKOa0YWbldvE477ZeaxKgsT2i7PWhVTZ5VGXYz6pvKWkAePhgyCkaT
         nbuSBgs5iKsM8NCF3dSAsgS0M+MwEajyDqoLzV4Ci1HjrTxavHyKHk2l2CZLyf4N1gvZ
         pu5fprOZDY2SASlkwIli8xvWqCpan/lqeR/qDAlSv+pTP/3e3LnNlTKcX6K4MPCn5XVO
         l/qbwN+PIxwV2v2wVl5wo2rfoTlx7tCJ5gMIa3Wc+4jcTx1vHVFj3PCwJqw8Lt4wVxCz
         WcCA==
X-Gm-Message-State: AGi0Pua4sVrLFk0dbtNztGqbVfU/xQ/RFAm1e3wtgjYRQy7kjFlkuCBY
        y9HvjJR6STaDfz0nrZzN8mjFaqdWzES1T/IsctWBytldA/rQRX1bOi6vang1nlw20lIv59SfLbV
        MGzzCeJOtQ0hxsw9wA3B+0kso
X-Received: by 2002:adf:8b48:: with SMTP id v8mr24030453wra.342.1586849057503;
        Tue, 14 Apr 2020 00:24:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypLtrfmuCf0M1UB8Gt1fdMPP0/wRgXiMSAmQSalr2WD7RZeytY8N0oXiVfPOgVqAPVBvMs4T4Q==
X-Received: by 2002:adf:8b48:: with SMTP id v8mr24030434wra.342.1586849057273;
        Tue, 14 Apr 2020 00:24:17 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id p6sm10528834wrt.3.2020.04.14.00.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 00:24:16 -0700 (PDT)
Subject: Re: [RFC][PATCH 00/36] objtool: Make recordmcount a subcommand
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>
References: <cover.1586468801.git.mhelsley@vmware.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <3a3f70df-07b0-91d9-33e1-e997e72b0c5c@redhat.com>
Date:   Tue, 14 Apr 2020 08:24:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1586468801.git.mhelsley@vmware.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On 4/10/20 8:35 PM, Matt Helsley wrote:
> recordmcount has its own ELF wrapper code and could utilize
> objtool's ELF code to more-portably handle architecture variations.
> This series makes recordmcount a subcommand of objtool.
> 
> The initial 5 patches make objtool compilable for more than x86.
> Unlike recordmcount the check command and orc tools are not currently
> checking other architectures so we need a way to cleanly build
> objtool for those architectures that don't support check / orc. I
> went with using weak symbols and added a "missing" architecture
> which can be used to indicate the tool is not implemented while
> avoiding the need for every architecture to explicitly specify
> which subcommands / features are not implemented. I'm curious if
> there are better approaches folks recommend though -- this is the
> one I landed on. The patches do not add HAVE_OBJTOOL to all
> architectures.
> 

If all you need from objtool it the elf parsing code, wouldn't it make 
more sense to move that out of objtool, as a utility library that both 
objtool and recordmcount could use (and perhaps other tools in the future?)

In patch 3 you seem to mention that other tools already have their own 
code to parse elf. So instead of converting everything as an objtool 
subcommand, maybe just have the library with the required functionality.

Any opinions on the above? What do people prefer?

Cheers,

-- 
Julien Thierry

