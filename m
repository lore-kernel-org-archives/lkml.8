Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D40C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3382075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzjXo7Aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgHYMte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:49:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38626 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729372AbgHYMtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598359751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2cbENVwZDuEmq7Y+JiiFnjSHv5sQfWHtT+16663LunI=;
        b=FzjXo7AjAFrCeH6NgJAyzxT7hF9Xc/qAuCogApNQuzekOWX+GVShq7hc5P3exlIn8J7UfU
        gGVTHlzNysJth1P0DCrthq19rY01CC95xn7J99uSm4e7V1ViDED5no10AjWd8+bjFQKwtJ
        Nd2mhx5iA9dsmDvrtzZRMY8Cs2Do0/4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-lHpUuQjVPi-HejwtZRDGWw-1; Tue, 25 Aug 2020 08:49:10 -0400
X-MC-Unique: lHpUuQjVPi-HejwtZRDGWw-1
Received: by mail-wm1-f70.google.com with SMTP id r14so699821wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2cbENVwZDuEmq7Y+JiiFnjSHv5sQfWHtT+16663LunI=;
        b=J08tQvUDyVnFywEyIHdxNzoStUSElECKExwomecl77D6h5xSkWljAvClLH+g98P5Pa
         RU2NPa+iRsD8EgvH1ecP3JYAOTzE7Z91Bj/jskUXakoRNH4WTMQmX5mBPzOe9m6klONA
         oKGibBWP4p/8q9ZAesEvNJzW+ytKGpKz5EAdVD8Joc+EzzlQgv0B3XWkAP8RiXkQsWbD
         y9kI1eOzH9fNUJkcoLtPz1goMOKbiQx7/5ZW547c69aID4ip1fW2OWt18J12htMWO/YQ
         +qdawKfODl2Zbabp1KHZ/tN//SR00eXe4aDzopTnT1CGacVMzWA6rQB3NHHnN2f5BcqT
         bNGQ==
X-Gm-Message-State: AOAM533taOhkCEl/NsqFBLuT84W9b/luBS2RdrYBCbr7R38L9V1ULtK0
        3wdwWaWonRX80WKHGZ/Yl1GZQDC/7Tcxko4dEfG4XRI5V+yDx08mlBfnxoblAQlHDc2ibHiDI4o
        eo+HZWu+LjeO6dfbge1b49yEZ
X-Received: by 2002:adf:9283:: with SMTP id 3mr10403578wrn.70.1598359748940;
        Tue, 25 Aug 2020 05:49:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxN9gfbiXLS3FXlknqEUTpyobm1UaS3fx3Umjd+xf3wr9fw7fymjKhATua12i3qZKiqps4MNA==
X-Received: by 2002:adf:9283:: with SMTP id 3mr10403569wrn.70.1598359748763;
        Tue, 25 Aug 2020 05:49:08 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id y16sm30120301wrr.83.2020.08.25.05.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 05:49:08 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] Remove dependency of check subcmd upon orc
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        benh@kernel.crashing.org
References: <20200825124700.29616-1-jthierry@redhat.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <3ef3dd0e-8820-1734-d11e-58a5c9390dd6@redhat.com>
Date:   Tue, 25 Aug 2020 13:49:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200825124700.29616-1-jthierry@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the duplicate send. An issue happened while sending this one. 
Please ignore this thread.

Thanks,

Julien

On 8/25/20 1:46 PM, Julien Thierry wrote:
> Hi,
> 
> Matt Helsley's change[1] provided a base framework to opt-in/out
> objtool subcommands at compile time. This makes it easier for
> architectures to port objtool, one subcommand at a time.
> 
> Orc generation relies on the check operation implementation. However,
> the way this is done causes the check implementation to depend on the
> implementation of orc generation functions to call if orc generation is
> requested. This means that in order to implement check subcmd, orc
> subcmd also need to be implemented.
> 
> These patches aim at removing that dependency, having orc subcmd
> being built on top of the check subcmd.
> 
> 
> Changes since v3 [2]:
> - Rebased on v5.9-rc1
> - Renamed objtool_setup_file() to objtool_open_read()
> - Fixed misplaced elf_write() when file->elf->changed is true
> - Avoid additional allocation for orc data and compile out orc
>    definition when not needed instead
> 
> [1] https://www.spinics.net/lists/kernel/msg3510844.html
> [2] https://lkml.org/lkml/2020/7/30/415
> 
> Cheers,
> 
> Julien
> 
> -->
> 
> Julien Thierry (4):
>    objtool: Move object file loading out of check
>    objtool: Move orc outside of check
>    objtool: orc: Skip setting orc_entry for non-text sections
>    objtool: check: Use orc definition only when needed
> 
>   tools/objtool/Makefile        |  4 +++
>   tools/objtool/arch.h          |  2 ++
>   tools/objtool/builtin-check.c | 15 ++++++++++-
>   tools/objtool/builtin-orc.c   | 27 +++++++++++++++++++-
>   tools/objtool/check.c         | 47 ++++++-----------------------------
>   tools/objtool/check.h         |  2 ++
>   tools/objtool/objtool.c       | 29 +++++++++++++++++++++
>   tools/objtool/objtool.h       |  4 ++-
>   tools/objtool/orc_gen.c       |  3 +++
>   tools/objtool/weak.c          |  4 +--
>   10 files changed, 92 insertions(+), 45 deletions(-)
> 
> --
> 2.21.3
> 

-- 
Julien Thierry

