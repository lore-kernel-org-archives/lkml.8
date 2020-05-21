Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6CEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECFE207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CROhW/Nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgEUOId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:08:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60749 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729694AbgEUOIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590070108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KYPruZ8qzCyc8Zuc6WzgrqHrImI6iIZQ3tFwxDcY6eQ=;
        b=CROhW/Nn+DaXil3ov1N0YAoYTV2ndGV+TnLHR33TfunCrWqR/Q/4KEiygxq4XVTEHI2utG
        DOEqah3J15E2t8rwYkV6qlUbT+7T2omUykw5rjA5oF42sGOsnhmW0zKJIaEso5V0sYyPCo
        tD3RGiqqfIPSNpqYdPDV7vosvV3BMws=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-0QVl5IHROVudUTyPPcQFvA-1; Thu, 21 May 2020 10:08:22 -0400
X-MC-Unique: 0QVl5IHROVudUTyPPcQFvA-1
Received: by mail-wm1-f70.google.com with SMTP id m11so1894796wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KYPruZ8qzCyc8Zuc6WzgrqHrImI6iIZQ3tFwxDcY6eQ=;
        b=C6cY5/OO/X1iIxTNzA1rhnlQRWzx4DZnQW98TJR27zoWHXEIA/XtlzBPU8VGFoM3aS
         A1iJuTz/iPqPygQZAzk64bStFFlDuPZ7fTviaFz3NtCBXtBPQmfjgFvFFjq7iDVUrjUR
         FAeD9+jp26RiqSy0LgyA4+YzWe7teJzHyZ316WUIhwkX7AcBg10GwiVLHa/Y9+9m41lT
         7s9IsBb3JVSnQl4ypaw425xjx6EQqqFaBch9RAQMw2aw70tTSA5U6HjkNbxRCSYv1LuI
         Y5emSpYH+ysEjwJzxb1VhjSo4//5qcY7RxYFDM8inzQ51gi/s+oAqq0msR9Y8LFR1Tus
         P0zg==
X-Gm-Message-State: AOAM530nvrDLKMR3Bq/sc66IBlICFe924LHAoq+ReTXijvY2Fvcw3LZy
        eKMC0D9fx6JrlCy2w6gUiL3GNwaLGvc88KoFduFFbUGx6m4QU/K5hEuT+RtXIiBDBISOmN+ckBZ
        snuegHknFd+FaZWqk7rtHqQK0
X-Received: by 2002:a1c:7c0b:: with SMTP id x11mr9419092wmc.149.1590070101175;
        Thu, 21 May 2020 07:08:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeqE8s6kqITQ5zRCGAR7thbTgJ+XBuN/t8JKtVxsAPKAeoBu546k0CmcwDaZnB6+qd45/Ykw==
X-Received: by 2002:a1c:7c0b:: with SMTP id x11mr9419073wmc.149.1590070100967;
        Thu, 21 May 2020 07:08:20 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
        by smtp.gmail.com with ESMTPSA id q144sm7012698wme.0.2020.05.21.07.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 07:08:20 -0700 (PDT)
Subject: Re: [PATCH v2 03/22] KVM: SVM: immediately inject INTR vmexit
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     wei.huang2@amd.com, cavery@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Oliver Upton <oupton@google.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200424172416.243870-1-pbonzini@redhat.com>
 <20200424172416.243870-4-pbonzini@redhat.com>
 <87blmhsb7y.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8bc4c38a-1717-1e4f-b322-fdd51f614717@redhat.com>
Date:   Thu, 21 May 2020 16:08:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87blmhsb7y.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/20 14:50, Vitaly Kuznetsov wrote:
> Sorry for reporting this late but I just found out that this commit
> breaks Hyper-V 2016 on KVM on SVM completely (always hangs on boot). I
> haven't investigated it yet (well, this is Windows, you know...) but
> what's usually different about Hyper-V is that unlike KVM/Linux it has
> handlers for some hardware interrupts in the guest and not in the
> hypervisor.

"Always hangs on boot" is easy. :)  At this point I think it's easiest
to debug it on top of the whole pending SVM patches that remove
exit_required completely (and exit_required is not coming back anyway).

Can you get a trace and send it to me?

Paolo

