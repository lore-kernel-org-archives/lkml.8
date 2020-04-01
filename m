Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88FFC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E0421556
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1x0ZSoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbgDAMov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:44:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34188 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732396AbgDAMov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585745090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tcijslMDnWOfEx2XWs1GjD/Qz1G2+HgOCl78SG26EZw=;
        b=X1x0ZSoZL+9GmhrjwDFILO8hmbzkGe4I5liQKq+eqRDaTQpm2y01ACi2TP+/GeU3XQeanO
        yjgvSNduIG7smqIHAVAHO1VZ61FF2oUsBsh4rYOUHQRGkp67N2qYjqu99wa93OthlfP/ia
        oJcO3OGLWh8eQNk2ojS9Lf6uIy9D6gE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-mR7k_A5LMp6IPau-SFrA9Q-1; Wed, 01 Apr 2020 08:44:49 -0400
X-MC-Unique: mR7k_A5LMp6IPau-SFrA9Q-1
Received: by mail-wm1-f69.google.com with SMTP id o5so2403826wmo.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 05:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tcijslMDnWOfEx2XWs1GjD/Qz1G2+HgOCl78SG26EZw=;
        b=HXJPeONL9jGadkQjx7bynj+SKaRFNmhOp7p6PQxDYRcILcw0E13XDwflGuGIyCyS7/
         1NuMkcs9xgsmQBKhtdYA5onRMP5pPEPBnnX0mW1McMFY5/r98pgvxCvlYlTjob6mJuVc
         UBAcMcriPBY0fOoZh2cSlPXmv95JobkveGCw8SV6Obl9ljMwrlXsUUMe1dAz/oc4DsY+
         WR4yXyI3/XAx4qP2LKbO1kQVC7azcZ17QkTfqMm/eyEY2Hd7MnuVoSArci2fCvQHXLRR
         ELRk9u4PXEKjQus5pcDQvM2VxuKcpn5Hy5p/Whp+q7O4Z93EqeBVmK8DXiKhb8CF4sMd
         DdFA==
X-Gm-Message-State: AGi0PuZLMQemOpeCpjpyApW1BkeHsHc24IX1KizWia1INItw+1GMda28
        hpIpteJoopkk0tOu8qn0gyMgcZwjB0gJ245SlGncGcnCe0U86wxvvIkP4SvyNCYNWnMP37Ni1Fw
        UnhNvbypOV2UJgbZCf8OTBlbk
X-Received: by 2002:a1c:f407:: with SMTP id z7mr4091925wma.36.1585745088010;
        Wed, 01 Apr 2020 05:44:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypJrDTu5ANdvkOMwlFa8K92TqpJBdyWszxi6t6AVZlWfpKsIA3YEL4IQoSasbctxElxVwRUcmA==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr4091905wma.36.1585745087755;
        Wed, 01 Apr 2020 05:44:47 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id d21sm2777071wrb.51.2020.04.01.05.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 05:44:47 -0700 (PDT)
Subject: Re: [PATCH v2 01/10] objtool: Move header sync-check ealier in build
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, raphael.gault@arm.com
References: <20200327152847.15294-1-jthierry@redhat.com>
 <20200327152847.15294-2-jthierry@redhat.com>
 <alpine.LSU.2.21.2004011430120.15809@pobox.suse.cz>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <315c119a-0986-a3a0-7243-5fe0dd9038ea@redhat.com>
Date:   Wed, 1 Apr 2020 13:44:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.2004011430120.15809@pobox.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/20 1:32 PM, Miroslav Benes wrote:
> On Fri, 27 Mar 2020, Julien Thierry wrote:
> 
>> Currently, the check of tools files against kernel equivalent is only
>> done after every object file has been built.
> 
>> This means one might fix
>> build issues against outdated headers without seeing a warning about
>> this.
> 
> Could you explain the above in more detail, please?
> 

I must admit that this patch is more fixing the issues I've faced while 
working on the arm64 support and sharing some kernel headers from the 
arch/arm64 tree.

The annoying part was:
- Have build errors in objtool
- Fix them
- Objtool build succeeds, but have warning about outdated headers
- Update headers
- New errors come up, potentially making obsolete the ealier fixes

So it's not really a "must have" change. But it's nice to have when 
bringing new kernel headers to objtool.

I hope this makes things clearer.

Cheers,

-- 
Julien Thierry

