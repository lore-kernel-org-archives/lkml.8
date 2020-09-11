Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31810C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0282221EE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgIKLId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:08:33 -0400
Received: from foss.arm.com ([217.140.110.172]:60002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgIKLIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:08:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2279113E;
        Fri, 11 Sep 2020 04:07:59 -0700 (PDT)
Received: from [10.57.10.92] (unknown [10.57.10.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CA4B3F68F;
        Fri, 11 Sep 2020 04:07:58 -0700 (PDT)
Subject: Fwd: Re: [PATCH] dt-bindings: arm: Add devicetree binding for
 cpu-performance-dependencies
References: <acaa849d-c106-614d-7952-142716e750ae@arm.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@infradead.org,
        linux-kernel@vger.kernel.org
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
X-Forwarded-Message-Id: <acaa849d-c106-614d-7952-142716e750ae@arm.com>
Message-ID: <643a8784-492d-8644-f180-22ab2f4b5fba@arm.com>
Date:   Fri, 11 Sep 2020 12:08:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <acaa849d-c106-614d-7952-142716e750ae@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/8/20 8:26 PM, Rob Herring wrote:
> On Tue, Sep 8, 2020 at 8:53 AM Nicola Mazzucato
> <nicola.mazzucato@arm.com> wrote:
Hi Rob, thanks for your prompt reply. Please find my comments below.
> So while this resend fixes the problem of not getting into DT
> patchwork, you've dropped everyone else. The correct thing to do is
> follow what get_maintainers.pl outputs as a starting point. That's not
> exact as often you may or may not want 'commit signers' though I think
> this wouldn't apply here given it's a new file. For this one, it's Arm
> related so LAKML should be Cc'ed. As well as, Sudeep for SCMI, Viresh,
> Daniel and probably others for power management related knowledge.
Apologies, the recipients list got mixed up.
>
> Where's the kernel implementation? Not strictly needed for adding a
> binding, but more people will pay attention if there's an
> implementation.
Agree. I didn't include the kernel implementation on purpose, because I would
like to find an agreement on the binding first. Once we have it, I will update
the patch with the fixes and after that I will present the kernel
implementation. The consumers for this information will be EAS and the thermal
framework.
>> Currently, there is an assumption that the performance domains as provided
>> by the SCMI protocol should be mirroring the exact implementation in
>> hardware, for example, the clock domains, which are a typical type of
>> performance domains.
>>
>> By design, an SCMI performance domain defines the granularity of
>> performance controls, it does not describe any underlying hardware
>> dependencies (although they may match in many cases).
>>
>> As a consequence, in platforms where hardware may have the ability to
>> control cpu performance at different granularity and choose to describe
>> fine-grained performance control through SCMI performance domains, there
>> is currently no way for OSPM to discover the actual cpu hardware
>> dependencies. Inevitably, software components that rely on this missing
>> description will cease to work.
>>
>> Thus, there is a need for a new description of hardware dependencies where
>> the performance level is coordinated by hardware (or firmware) since these
>> dependency domains might be larger than the SCMI performance domains.
> Wouldn't non-SCMI platforms need to describe the same dependencies? On
> the flip side, why doesn't SCMI make itself discoverable rather than
> putting this in DT?

The example given here is referring to SCMI in order to provide a clear and
direct example of a scenario. However, the proposed binding is not SCMI
specific. It allows DT to describe a generic hardware property, CPU performance
dependency, which may not be available through other sources.

SCMI is designed to offer points of control, not hardware description, and
therefore lacks this information. Other platforms with FW/HW coordinated
performance control may need to provide the same information to the OS and can
use this binding too.

>
> How does this relate to OPPs? Wouldn't we have an OPP per 'performance domain'?
OPPs are related to CPUs. The binding is describing which CPUs are roughly
linked in terms of performance level due to hw implementation. The exact
performance level of each CPU may vary within the same dependency domain.
>
> How does this relate to idle states? Aren't they going to have the
> same dependencies at least for cluster level states?
Since you can mix and match different cores types within a cluster, having two
of three performance dependency domains within a cluster would be expected.
>
> I'd like to see a complete example with OPPs, idles states, etc. all included.

This could be a platform where this binding would be necessary:

CPU:              0    1    2    3    4    5    6    7
Type:             A    A    A    A    B    B    B    B
Cluster:         [                                    ]
perf-controls:   [  ] [  ] [  ] [ ]  [ ]  [ ]  [ ]  [ ]
perf-dependency: [                ]  [                ]
HW clock:        [                ]  [                ]

Idle-states are unrelated (ACPI describes separately as well).

>
>> This new optional binding will provide visibility to OSPM on any hardware
>> or firmware coordination of performance requests and enable more
>> accurate assumptions about performance and performance side-effects of
>> requesting performance level changers. This is essential information for
>> OSPM thermal and energy management frameworks.
>>
>> There are two main reasons to support this new addition:
>>
>> 1) Per-cpu control & SCMI performance domains
>>
>> Same as explained above. Some platforms would like to make aggregation
>> decisions in firmware and want to describe themselves as having per-cpu
>> control. In order to continue to make sane decisions in the OSPM layer,
>> we need to know about the underlying connections.
>>
>> With this optional binding, we provide performance dependencies
>> information to OSPM for sets of CPUs while the h/w coordinates the
>> performance level for each cpu.
>>
>> 2) ACPI
> ACPI is not really relevant to a DT binding patch.

True. It is there only for completeness of information and offer a wider picture
on the context. It provides a comparison with dt, showing that ACPI provides
both controls and dependencies information to be provided to the OS.

Can be removed if required (this and the above).

>
>> With respect to performance, ACPI describes two main types of coordination
>> that may take place in system when logical processors are required to
>> transition to a different power/performance state. These two types are
>> software coordination (SW) and hardware coordination (HW). In the first
>> one, OSPM is in charge of handling such transitions while preserving the
>> integrity of the entire system. In the latter case, the h/w is responsible
>> for ensuring correct operations.
>>
>> In the HW coordination, OSPM can control each processor as if they were all
>> independent each other. However, platforms can use ACPI defined interfaces
>> to group CPUs to create so called "dependency domain". Such interface is
>> the _PSD method. Users in kernel that need to know dependencies among
>> cores, can retrieve such information via _PSD [1].
>>
>> If the same system needs to work with dt + SCMI, we will have all the
>> controls, but we are missing the information performance level coordination
>> in hardware/firmware.
>> This new dt binding provides the missing bits.
>>
>> [1]ACPI Specification, version 6.3 - 8.3 Power, Performance, and Throttling
>> State Dependencies
>>
>> Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
>> ---
>>  .../bindings/arm/cpu-perf-dependencies.yaml   | 45 +++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/cpu-perf-dependencies.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cpu-perf-dependencies.yaml b/Documentation/devicetree/bindings/arm/cpu-perf-dependencies.yaml
>> new file mode 100644
>> index 000000000000..3b8cf7e29982
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/cpu-perf-dependencies.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/cpu-perf-dependencies.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: CPU Performance Dependencies
>> +
>> +maintainers:
>> +  - Nicola Mazzucato <nicola.mazzucato@arm.com>
>> +
>> +description: |+
>> +  This optional node provides information to OSPM of cpu performance
>> +  dependencies.
>> +  Each list represents a set of CPUs which have performance level
>> +  dependencies and can assumed to be roughly at the same performance
>> +  level coordinated by hardware and/or firmware.
>> +  Example: Describing CPUs in the same clock domain.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - arm,cpu-perf-dependencies
>> +
>> +  cpu-perf-affinity:
>> +    $ref: '/schemas/types.yaml#/definitions/phandle'
>> +    description: |
>> +      Specifies a list of phandles to CPU nodes corresponding to a set of CPUs
>> +      which have performance affinity.
>> +
>> +examples:
>> +  - |
>> +    cpu-performance-dependencies {
>> +        compatible = "arm,cpu-perf-dependencies";
>> +        cpu-perf-domain0 {
> What does 0 correspond to? Just making up indices or ???
It's an example and simply an attempt to make it as generic as possible. I could
not come up with better names. Open for suggestions.
>
>> +            cpu-perf-affinity = <&CPU0>, <&CPU1>, <&CPU2>, <&CPU3>;
>> +        }
>> +        cpu-perf-domain1 {
>> +            cpu-perf-affinity = <&CPU4>, <&CPU5>, <&CPU6>;
>> +        }
>> +        cpu-perf-domain2 {
>> +            cpu-perf-affinity = <&CPU7>;
>> +        }
>> +    };
>> --
>> 2.27.0
>>

