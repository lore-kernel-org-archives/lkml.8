Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A06AC35246
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726E120674
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTOfv6eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgBASvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:51:47 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58738 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726270AbgBASvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580583105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tB9Flr5JK1dOLBjqc7BgpGrNDesYmTAkGtr8sueGsTM=;
        b=iTOfv6eqpUFG2yeYZ7k58zliLjA6Hvpd2Hmjcbk8/uPVzNhYoy2JXejXwA41S2Vec4RaZ9
        Ug/Ap8hdVPr0Y0uXmnbM1XSknPkFJSgH6ei0Qy8hBxCkWc+AiDrY3ncQOFchthD7G6B6Jq
        IY9DS0V9qTGKM3NROcIEQJpXrkx295M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-Y6DrYIhcP6OHgKmWEmdN_w-1; Sat, 01 Feb 2020 13:51:43 -0500
X-MC-Unique: Y6DrYIhcP6OHgKmWEmdN_w-1
Received: by mail-wr1-f70.google.com with SMTP id l1so263626wrt.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 10:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tB9Flr5JK1dOLBjqc7BgpGrNDesYmTAkGtr8sueGsTM=;
        b=Mqob5gMmHLBF/wFoS7wjKjftmPqI6Yk3Z2iA4YAr9MiSxC/iKrRBo2V0bS97nZ0ZlV
         /I0EL9AvRcv7xJaVtGzlKTfzKh9oPmFdeNLjSSXHopkW2supDwGIixYwL+vaIwOZwdd4
         80xLodhUVkTnGxmrsZecJOPythYsZNcVoATAIpMi0+5Wum4QLGbiSgw8Up9jEuzTHHDK
         XVKQgGDh0PYbkUc1xabYZj5Tz4TXezhWOLl+/K6zx5ug3P3vnzOu74bULGlSafApyHHe
         SKbiyJ9rktipW6y+SVaEyMCIvSGWtJ2wqZ0LDJ6d4FcWmW05g+IidYyvkMNAeQkklvTo
         lcxw==
X-Gm-Message-State: APjAAAVByd2cwzr1RU3Nofy+zwDSrNA2Fl9brFi8lN/bvAZjMEW/KdkG
        cDqm/s69H7Fr4imkF7CDqKqJKIyAKmbp/gv2Pzff2o8dhOogM/DwM+CQ55Anuiyy2QfA7MXE3gF
        1+Jj4mfwUrbK3LTBhs0s6KFe1
X-Received: by 2002:a1c:df09:: with SMTP id w9mr18132178wmg.143.1580583102838;
        Sat, 01 Feb 2020 10:51:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwtrcXwlNs8N5xVK7R4JMHvfTqKW8jsp2y194o5nU+n5b3kfGYl/Ti0Cx6Ye68n+xpLiX6iEA==
X-Received: by 2002:a1c:df09:: with SMTP id w9mr18132164wmg.143.1580583102550;
        Sat, 01 Feb 2020 10:51:42 -0800 (PST)
Received: from [192.168.42.104] (93-33-54-106.ip43.fastwebnet.it. [93.33.54.106])
        by smtp.gmail.com with ESMTPSA id e8sm17306814wrt.7.2020.02.01.10.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2020 10:51:42 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: Fix perfctr WRMSR for running counters
To:     Eric Hankland <ehankland@google.com>
Cc:     Jim Mattson <jmattson@google.com>, Peter Shier <pshier@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200127212256.194310-1-ehankland@google.com>
 <2a394c6d-c453-6559-bf33-f654af7922bd@redhat.com>
 <CAOyeoRVaV3Dh=M4ioiT3DU+p5ZnQGRcy9_PssJZ=a36MhL-xHQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1cec3c8-570f-d824-cb20-6641cf686981@redhat.com>
Date:   Sat, 1 Feb 2020 19:51:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAOyeoRVaV3Dh=M4ioiT3DU+p5ZnQGRcy9_PssJZ=a36MhL-xHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/20 02:09, Eric Hankland wrote:
> Sorry - I forgot to switch to plain text mode on my first reply.
> 
>> I think this best written as it was before commit 2924b52117:
>>
>>                         if (!msr_info->host_initiated)
>>                                 data = (s64)(s32)data;
>>                         pmc->counter += data - pmc_read_counter(pmc);
> Sounds good to me.
> 
>> Do you have a testcase?
> I added a testcase to kvm-unit-tests/x86/pmu.c that fails without this
> patch and passes with it. Should I send out that patch now?

Yes, please send it!  Thanks,

Paolo

