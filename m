Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C6DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251ED20708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFRC4axw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgETIEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:04:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55745 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726436AbgETIEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589961885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tODKxPEhKOy3EtWiEeXfICX4Oq3a9d2MWwv3RjPjgr8=;
        b=HFRC4axwnvlDfvaRBPAKds6CcKzXO9TKcGFhVwrUU8WAgv1JD9cogxmfYQ47V9i0KiSxFO
        A3/HW9adgMmLX/2cob1JLjT5CEUNsLSsY5R3DuS6XO5r0Qah0qBn17s6HYuPq6G9qIRecD
        RcyaVrk0UtlD4DHV4zFHCX3bfi/d81E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-xQsKOu-BMuekTitgqdHZ0A-1; Wed, 20 May 2020 04:04:44 -0400
X-MC-Unique: xQsKOu-BMuekTitgqdHZ0A-1
Received: by mail-wr1-f70.google.com with SMTP id l12so1064420wrw.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tODKxPEhKOy3EtWiEeXfICX4Oq3a9d2MWwv3RjPjgr8=;
        b=pVrpY0JIXsIdrDmafDfun9WUK4ZrNn5V7iJvqi6rASn8nAcxiMFcYx9Jz9J/zPjAeK
         +HYvvC9FIwqV7ZGF1Ab+wPZ+1lgQc/rN0s/v6wVltqDuOcJqnzQGIhA1vwwhRZMb4QnB
         mNd/Xzv1wgX9X/LYKXpPVHJ+BHk8vHajqvg6Oxx1twXf4cnbBtaRdVpWDcDpcszQoqS2
         fUq4C5IBTk/o7qOGFwfHL6S1xJ56Xq+pIvy7nZYYbxny5VwXF55qneofy2LjhjRkZZG1
         5Ud/Thds8yt/046yQlXCsYJVvYwKwpoPOEX7w70gcwXh1bsL9gToH2f91e5OoeAdXpX7
         uqpQ==
X-Gm-Message-State: AOAM530k5YwU/Y+lYMhy4H2WBMByMq5VesgQuxcuIzYMt+aLppBISeez
        hEbod9BLtNjhdxDgSyUUK6lTopkFqZiC7oxkMFR8rOqn22tfOAt7iq7mhM2y2JKba9uil5H4f9e
        NXOzo/d5VUQGnpW4GMhA6G+u9
X-Received: by 2002:a05:6000:11ca:: with SMTP id i10mr3138764wrx.10.1589961882841;
        Wed, 20 May 2020 01:04:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzY2cSIgL58y2H/BiNwiTnt+p2jmmQ05xVyK44+WVRrlhAbO7zIFMCD6cJ85iRgSS3nhSobmg==
X-Received: by 2002:a05:6000:11ca:: with SMTP id i10mr3138741wrx.10.1589961882676;
        Wed, 20 May 2020 01:04:42 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id n9sm2370316wmj.5.2020.05.20.01.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 01:04:42 -0700 (PDT)
Subject: Re: [PATCH 2/3] objtool: Move struct objtool_file into
 arch-independent header
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1589913349.git.mhelsley@vmware.com>
 <8a877bc283cbad704c7472ac3ef534d49629dd05.1589913349.git.mhelsley@vmware.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <46066936-eb20-1b64-eef1-9b57aeab3a73@redhat.com>
Date:   Wed, 20 May 2020 09:04:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8a877bc283cbad704c7472ac3ef534d49629dd05.1589913349.git.mhelsley@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/20 9:55 PM, Matt Helsley wrote:
> The objtool_file structure describes the files objtool works on,
> is used by the check subcommand, and the check.h header is included
> by the orc subcommands so it's presently used by all subcommands.
> 
> Since the structure will be useful in all subcommands besides check,
> and some subcommands may not want to include check.h to get the
> definition, split the structure out into a new header meant for use
> by all objtool subcommands.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>

Reviewed-by: Julien Thierry <jthierry@redhat.com>

-- 
Julien Thierry

