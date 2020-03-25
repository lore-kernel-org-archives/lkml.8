Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D778FC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 03:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E29120724
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 03:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pEnsu4NT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgCYDbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 23:31:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48455 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbgCYDbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 23:31:23 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (jfdmzpr04-ext.jf.intel.com [134.134.137.73])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 02P3Ux0G3339745
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 24 Mar 2020 20:31:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 02P3Ux0G3339745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020032201; t=1585107061;
        bh=Knm646lHXwlpT0sefOB8j/QUNfPkjACyujqtgJGoOBM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pEnsu4NTAVl61kfywRqIK5Du3Pg5RTHz17RBMkj0+1rxaQGZ23dJp7cWeND6eObJ2
         BTBYIsTXqRzwiq+TeVqTQ6jnPyfXTjzTzwSVjPMjCo2Ff8vk5eSK1GPIiflqa0jvH+
         N84bJBfc90yERWn6CcYhD5oeQey6ga3zM2aOvOuirqLe+iEgSvZgic8mOlqXRPsIKz
         Bn7+TIbrnx/12LoZ/ZqKM/QmbpXjqS7gj6ACiROzyOr18UB7CXcaFMuUd1uP2SRD/i
         bxUO627vgsuFSTDJscjsppYZS3VXcdP9ZopJ59y1NdaAWZ0w+gNgVHLV1VLdwVqefR
         aIPSKUfzu16GQ==
Subject: Re: [PATCH 1/1] x86 support for the initrd= command line option
To:     ron minnich <rminnich@gmail.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com>
 <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com>
 <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com>
 <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com>
 <CACdnJusmAHJYauKvHEXNZKaUWPqZoabB_pSn5WokSy_gOnRtTw@mail.gmail.com>
 <A814A71D-0450-4724-885B-859BCD2B7CBD@zytor.com>
 <CAP6exYJdCzG5EOPB9uaWz+uG-KKt+j7aJMGMfqqD3vthco_Y_g@mail.gmail.com>
 <CF1457CD-0BE2-4806-9703-E99146218BEC@zytor.com>
 <CAP6exYJj5n8tLibwnAPA554ax9gjUFvyMntCx4OYULUOknWQ0g@mail.gmail.com>
 <C2B3BE61-665A-47FD-87E0-BDB5C30CEFF4@zytor.com>
 <CAP6exY+avh0G3nuqbxJj2ZgKkRdvwGTKeWyazqXJHbp+X-2u+A@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <0f31f437-c644-210c-8dc9-22630ab9bd0d@zytor.com>
Date:   Tue, 24 Mar 2020 20:30:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAP6exY+avh0G3nuqbxJj2ZgKkRdvwGTKeWyazqXJHbp+X-2u+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-23 15:29, ron minnich wrote:
> sounds good, I'm inclined to want to mention only initrdmem= in
> Documentation? or just say initrd is discouraged or deprecated?

Deprecated, yes.

	-hpa

