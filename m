Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C6EC8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4371520838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrG3sTnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD3KeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:34:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52785 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgD3KeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588242857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O6Ku2Z3+7Gg0z8xz3T+AzovdxSe8hvidTw18x0PtX7U=;
        b=WrG3sTnNjgquDP/5Wo8Rk0EOd2bDn5X6o79hO6JNT2uKWJ1KLHFG4NmUE5G6oU0lzzAak5
        yq+zSHMSpvnaXM4a2nYl4PvZtgODtfu4vwpE927FPakk/LD6IFH148SdjFbxramjK63oc+
        EpE0UH4entWQgV3I0FzQsVFi7TDc6Os=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-40pVYTubOYql3QZcJuO05A-1; Thu, 30 Apr 2020 06:34:13 -0400
X-MC-Unique: 40pVYTubOYql3QZcJuO05A-1
Received: by mail-wr1-f71.google.com with SMTP id v9so3637376wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 03:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O6Ku2Z3+7Gg0z8xz3T+AzovdxSe8hvidTw18x0PtX7U=;
        b=JHq3zcFUEPksgOoJvmmdx2N67qnP1OEoVc2ZprRu9QrwOfQQ6DKLV/bnYeLU/0rK+j
         sVNslBQ4sbs+WNwPzRStDLEXfmUPgrvH42TEyvqoFXdUO+h9UofHtNogcy7+5rwM7kvS
         t1AruZWFHqGXAISsuLNAVbcxqfm/klq82qE7AS7ISDTJx5Ty0iRz0jJaO+2gaMBtMTab
         gXBoJAaDXhcWaTeesaWAtieV5YnDx1hJnQN8GTjNoBF2U6+2Ir5ewVRG2Wb9jECFg1Qa
         NJ5+qqpRD+yVJ4K0C1aKCTxwZ7m254pss8sh7vd8kW4peFK75/kPkxHuLP++CYtfEF/t
         Bagg==
X-Gm-Message-State: AGi0Pub7qTJy4Wo59h851HHB7ZCkM9A3iR9inSTiyjkAbvaI2x8x5O5R
        vCdLB1E8ldmpN+Q2wV8IiciCbc92i9cFbMcxfQc0Lz3ZhGw0a3VrerGtZXKmhFewJVXIB1FZ+Nv
        FeeBmFvPp4ma+QvLB+G1oAlub
X-Received: by 2002:a1c:2dc7:: with SMTP id t190mr2134813wmt.129.1588242852576;
        Thu, 30 Apr 2020 03:34:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ8JsQg/OP5zAqqUR3nxYzLoB/7jOFw1DIV0upZ3g5xdHI4OwLaHIfuoLdosbs8ImUknyql+g==
X-Received: by 2002:a1c:2dc7:: with SMTP id t190mr2134792wmt.129.1588242852364;
        Thu, 30 Apr 2020 03:34:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id z22sm11673533wma.20.2020.04.30.03.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 03:34:11 -0700 (PDT)
Subject: Re: [PATCH v1 00/15] Add support for Nitro Enclaves
To:     Alexander Graf <graf@amazon.com>,
        "Paraschiv, Andra-Irina" <andraprs@amazon.com>,
        linux-kernel@vger.kernel.org
Cc:     Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>, Balbir Singh <sblbir@amazon.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>, kvm@vger.kernel.org,
        ne-devel-upstream@amazon.com
References: <20200421184150.68011-1-andraprs@amazon.com>
 <18406322-dc58-9b59-3f94-88e6b638fe65@redhat.com>
 <ff65b1ed-a980-9ddc-ebae-996869e87308@amazon.com>
 <2a4a15c5-7adb-c574-d558-7540b95e2139@redhat.com>
 <1ee5958d-e13e-5175-faf7-a1074bd9846d@amazon.com>
 <f560aed3-a241-acbd-6d3b-d0c831234235@redhat.com>
 <80489572-72a1-dbe7-5306-60799711dae0@amazon.com>
 <0467ce02-92f3-8456-2727-c4905c98c307@redhat.com>
 <5f8de7da-9d5c-0115-04b5-9f08be0b34b0@amazon.com>
 <095e3e9d-c9e5-61d0-cdfc-2bb099f02932@redhat.com>
 <602565db-d9a6-149a-0e1a-fe9c14a90ce7@amazon.com>
 <fb0bfd95-4732-f3c6-4a59-7227cf50356c@redhat.com>
 <0a4c7a95-af86-270f-6770-0a283cec30df@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c919928-00ed-beda-e984-35f7b6ca42fb@redhat.com>
Date:   Thu, 30 Apr 2020 12:34:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <0a4c7a95-af86-270f-6770-0a283cec30df@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/20 17:07, Alexander Graf wrote:
> 
> Why don't we build something like the following instead?
> 
>   vm = ne_create(vcpus = 4)
>   ne_set_memory(vm, hva, len)
>   ne_load_image(vm, addr, len)
>   ne_start(vm)
> 
> That way we would get the EIF loading into kernel space. "LOAD_IMAGE"
> would only be available in the time window between set_memory and start.
> It basically implements a memcpy(), but it would completely hide the
> hidden semantics of where an EIF has to go, so future device versions
> (or even other enclave implementers) could change the logic.

Can we add a file format argument and flags to ne_load_image, to avoid
having a v2 ioctl later?

Also, would you consider a mode where ne_load_image is not invoked and
the enclave starts in real mode at 0xffffff0?

Thanks,

Paolo

