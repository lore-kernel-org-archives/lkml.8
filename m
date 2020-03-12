Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BEAC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD636206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BC+cOO8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgCLPAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:00:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32194 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727363AbgCLPAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584025246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RPWm8AwSfw0eG4OBrSTSKA0oa/UVpusYPjdmHiVrCJg=;
        b=BC+cOO8H8Ms8i2GNH7LYmcPiGdG5BXtqqn/MHJnK0vcPKy5MaPR3qyIlD7dk4/1e6qPDcU
        DSO2eGX/PCjZ6YQuIf205MwDTPtuRcjZ5JUSASo1YNbeJVSGhtjo8I2SZWMVw0pAIiLyCA
        Xf0nN7QAu9tmhPQxv7iOtOwykMFUBRg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-XYs-1S40MqaetYIICw6mQg-1; Thu, 12 Mar 2020 11:00:44 -0400
X-MC-Unique: XYs-1S40MqaetYIICw6mQg-1
Received: by mail-wm1-f70.google.com with SMTP id s15so401302wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 08:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RPWm8AwSfw0eG4OBrSTSKA0oa/UVpusYPjdmHiVrCJg=;
        b=OPUq9dgOZnkN66SmglLbGFck55BNkCdMkdWmR8oB4e0FOugUZu97dup14ub6ezTPDN
         QTomkNYrf/RYNIveu2rC13HmTC0Ps8wA3rL4VCtnvZa3QGkWrO3gdxrS4GfoAqfrc4Vo
         i11fgUEbZE2PKE7ntAL3zMh8E4AxUba3gt2MHHSvuRGrRetkCFp1dLu2pZBHrO4Dschj
         o2PsaWkRc1glgQpiiyH3Frmf3lZFutMVOwGEweNrYS25ZrESoi6WYFWxL6IkCywBqWf5
         77XcL0SSIgbJWE4ilR1/K8tmTH63V1dPcNu+eL7o/9SNbDFKTGAiBOoUc0jOpYfR6yp0
         2xWA==
X-Gm-Message-State: ANhLgQ0hFmIehn9k3W0S+PJeQTFlO/BOzVUNismic1XPkNBXDelfxfOi
        zy+SsPbJflSFlfGbajM3qLhTcIpoZfr7MNPggFXa4Fbb+eRCwVjFTKkvtah41T08TAZ/5o/HxAk
        YF+JzqsA23vq6amehOizK8i6e
X-Received: by 2002:a7b:c20c:: with SMTP id x12mr5369828wmi.80.1584025243668;
        Thu, 12 Mar 2020 08:00:43 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv+tC2jQZowB2YfPlneEyVZ/xYyDnKqGw1zH6qmMf7afBiGb0FLNqPOcXVBu1mFXjAlzCi/5w==
X-Received: by 2002:a7b:c20c:: with SMTP id x12mr5369808wmi.80.1584025243455;
        Thu, 12 Mar 2020 08:00:43 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.186])
        by smtp.gmail.com with ESMTPSA id u204sm10177541wmg.40.2020.03.12.08.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 08:00:42 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] kvm: x86: Emulate split-lock access as a write
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@aculab.com>
References: <20200203151608.28053-1-xiaoyao.li@intel.com>
 <20200203151608.28053-4-xiaoyao.li@intel.com>
 <95d29a81-62d5-f5b6-0eb6-9d002c0bba23@redhat.com>
 <878sl945tj.fsf@nanos.tec.linutronix.de>
 <d690c2e3-e9ef-a504-ede3-d0059ec1e0f6@redhat.com>
 <20200227001117.GX9940@linux.intel.com>
 <18333d32-9ec4-4aee-8c58-b2f44bb8e83d@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9280995-942a-baad-7d67-db4f1a3015de@redhat.com>
Date:   Thu, 12 Mar 2020 16:00:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <18333d32-9ec4-4aee-8c58-b2f44bb8e83d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/20 12:42, Xiaoyao Li wrote:
>> I completely agree that poorly emulating the instruction from the 
>> (likely) malicious guest is a hack, but it's a simple and easy to
>> maintain hack.
> 
> What's your opinion about above?

That's okay, I suppose.

Paolo

