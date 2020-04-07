Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90E2C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B8D20730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 05:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgDGFO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 01:14:56 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:1559 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgDGFO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 01:14:56 -0400
X-Originating-IP: 2.7.45.25
Received: from [192.168.1.101] (lfbn-lyo-1-453-25.w2-7.abo.wanadoo.fr [2.7.45.25])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 4E2CF240006;
        Tue,  7 Apr 2020 05:14:53 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
Subject: Re: [RFC PATCH 6/7] dt-bindings: riscv: Remove "riscv,svXX" property
 from device-tree
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-264d030a-d77e-43b6-a2d8-d4598205e2af@palmerdabbelt-glaptop1>
Message-ID: <56690fc1-fdc3-67d9-5a39-e92d0ec6810c@ghiti.fr>
Date:   Tue, 7 Apr 2020 01:14:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <mhng-264d030a-d77e-43b6-a2d8-d4598205e2af@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/3/20 11:53 AM, Palmer Dabbelt wrote:
> On Sun, 22 Mar 2020 04:00:27 PDT (-0700), alex@ghiti.fr wrote:
>> This property can not be used before virtual memory is set up
>> and then the  distinction between sv39 and sv48 is done at runtime
>> using SATP csr property: this property is now useless, so remove it.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>  Documentation/devicetree/bindings/riscv/cpus.yaml | 13 -------------
>>  1 file changed, 13 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml 
>> b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> index 04819ad379c2..12baabbac213 100644
>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> @@ -39,19 +39,6 @@ properties:
>>        Identifies that the hart uses the RISC-V instruction set
>>        and identifies the type of the hart.
>>
>> -  mmu-type:
>> -    allOf:
>> -      - $ref: "/schemas/types.yaml#/definitions/string"
>> -      - enum:
>> -          - riscv,sv32
>> -          - riscv,sv39
>> -          - riscv,sv48
>> -    description:
>> -      Identifies the MMU address translation mode used on this
>> -      hart.  These values originate from the RISC-V Privileged
>> -      Specification document, available from
>> -      https://riscv.org/specifications/
>> -
>>    riscv,isa:
>>      allOf:
>>        - $ref: "/schemas/types.yaml#/definitions/string"
> 
> I'd prefer if we continue to define this in the schema: while Linux 
> won't use
> it, it's still useful for other programs that want to statically 
> determine the
> available VA widths.

Sure, I'll remove that in next version.

Thanks,

Alex
