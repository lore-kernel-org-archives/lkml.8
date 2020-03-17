Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78998C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8D0205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCQOJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:09:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725916AbgCQOJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:09:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HE23dq028026
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:09:01 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ytb4ufkks-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:09:01 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Tue, 17 Mar 2020 14:08:59 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Mar 2020 14:08:57 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02HE8uVF50593844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 14:08:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F9014C046;
        Tue, 17 Mar 2020 14:08:56 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A03704C05A;
        Tue, 17 Mar 2020 14:08:54 +0000 (GMT)
Received: from [9.199.61.203] (unknown [9.199.61.203])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Mar 2020 14:08:54 +0000 (GMT)
Subject: Re: [PATCH v4 3/3] powerpc/powernv: Parse device tree, population of
 SPR support
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        svaidy@linux.ibm.com, ego@linux.vnet.ibm.com, linuxram@us.ibm.com,
        pratik.sampat@in.ibm.com, pratik.r.sampat@gmail.com
References: <cover.1581505210.git.psampat@linux.ibm.com>
 <1f5138b5080606804162b0a7cf20c134589b96b1.1581505210.git.psampat@linux.ibm.com>
 <87tv2nptb8.fsf@mpe.ellerman.id.au>
From:   Pratik Sampat <psampat@linux.ibm.com>
Date:   Tue, 17 Mar 2020 19:38:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87tv2nptb8.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20031714-0012-0000-0000-00000392968B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031714-0013-0000-0000-000021CF75AB
Message-Id: <ec342c73-1e10-4e63-627d-01eaa2bd8593@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_05:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003170059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Michael for the review.


On 17/03/20 8:43 am, Michael Ellerman wrote:
> Pratik Rajesh Sampat <psampat@linux.ibm.com> writes:
>> Parse the device tree for nodes self-save, self-restore and populate
>> support for the preferred SPRs based what was advertised by the device
>> tree.
> These should be documented in:
>    Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt

Sure thing I'll add them.

>> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
>> index 97aeb45e897b..27dfadf609e8 100644
>> --- a/arch/powerpc/platforms/powernv/idle.c
>> +++ b/arch/powerpc/platforms/powernv/idle.c
>> @@ -1436,6 +1436,85 @@ static void __init pnv_probe_idle_states(void)
>>   		supported_cpuidle_states |= pnv_idle_states[i].flags;
>>   }
>>   
>> +/*
>> + * Extracts and populates the self save or restore capabilities
>> + * passed from the device tree node
>> + */
>> +static int extract_save_restore_state_dt(struct device_node *np, int type)
>> +{
>> +	int nr_sprns = 0, i, bitmask_index;
>> +	int rc = 0;
>> +	u64 *temp_u64;
>> +	u64 bit_pos;
>> +
>> +	nr_sprns = of_property_count_u64_elems(np, "sprn-bitmask");
>> +	if (nr_sprns <= 0)
>> +		return rc;
> Using <= 0 means zero SPRs is treated by success as the caller, is that
> intended? If so a comment would be appropriate.

My bad, this is undesirable. This should be treated as a failure.
I'll fix this.

>> +	temp_u64 = kcalloc(nr_sprns, sizeof(u64), GFP_KERNEL);
>> +	if (of_property_read_u64_array(np, "sprn-bitmask",
>> +				       temp_u64, nr_sprns)) {
>> +		pr_warn("cpuidle-powernv: failed to find registers in DT\n");
>> +		kfree(temp_u64);
>> +		return -EINVAL;
>> +	}
>> +	/*
>> +	 * Populate acknowledgment of support for the sprs in the global vector
>> +	 * gotten by the registers supplied by the firmware.
>> +	 * The registers are in a bitmask, bit index within
>> +	 * that specifies the SPR
>> +	 */
>> +	for (i = 0; i < nr_preferred_sprs; i++) {
>> +		bitmask_index = preferred_sprs[i].spr / 64;
>> +		bit_pos = preferred_sprs[i].spr % 64;
> This is basically a hand coded bitmap, see eg. BIT_WORD(), BIT_MASK() etc.
>
> I don't think there's an easy way to convert temp_u64 into a proper
> bitmap, so it's probably not worth doing that. But at least use the macros.

Right. I'll use the macros for a cleaner abstraction.

>> +		if ((temp_u64[bitmask_index] & (1UL << bit_pos)) == 0) {
>> +			if (type == SELF_RESTORE_TYPE)
>> +				preferred_sprs[i].supported_mode &=
>> +					~SELF_RESTORE_STRICT;
>> +			else
>> +				preferred_sprs[i].supported_mode &=
>> +					~SELF_SAVE_STRICT;
>> +			continue;
>> +		}
>> +		if (type == SELF_RESTORE_TYPE) {
>> +			preferred_sprs[i].supported_mode |=
>> +				SELF_RESTORE_STRICT;
>> +		} else {
>> +			preferred_sprs[i].supported_mode |=
>> +				SELF_SAVE_STRICT;
>> +		}
>> +	}
>> +
>> +	kfree(temp_u64);
>> +	return rc;
>> +}
>> +
>> +static int pnv_parse_deepstate_dt(void)
>> +{
>> +	struct device_node *sr_np, *ss_np;
> You never use these concurrently AFAICS, so you could just have a single *np.

Sure, got rid of it.

>> +	int rc = 0, i;
>> +
>> +	/* Self restore register population */
>> +	sr_np = of_find_node_by_path("/ibm,opal/power-mgt/self-restore");
> I know the existing idle code uses of_find_node_by_path(), but that's
> because it's old and crufty. Please don't add new searches by path. You
> should be searching by compatible.
>
Alright, I'll replace of_find_node_by_path() calls with of_find_compatible_node()

>> +	if (!sr_np) {
>> +		pr_warn("opal: self restore Node not found");
> This warning and the others below will fire on all existing firmware
> versions, which is not OK.

I'll get rid of the warnings. They seem unnecessary to me also now.

>> +	} else {
>> +		rc = extract_save_restore_state_dt(sr_np, SELF_RESTORE_TYPE);
>> +		if (rc != 0)
>> +			return rc;
>> +	}
>> +	/* Self save register population */
>> +	ss_np = of_find_node_by_path("/ibm,opal/power-mgt/self-save");
>> +	if (!ss_np) {
>> +		pr_warn("opal: self save Node not found");
>> +		pr_warn("Legacy firmware. Assuming default self-restore support");
>> +		for (i = 0; i < nr_preferred_sprs; i++)
>> +			preferred_sprs[i].supported_mode &= ~SELF_SAVE_STRICT;
>> +	} else {
>> +		rc = extract_save_restore_state_dt(ss_np, SELF_SAVE_TYPE);
>> +	}
>> +	return rc;
> You're leaking references on all the device_nodes in here, you need
> of_node_put() before exiting.

Got it. I'll clear the refcount before exitting.

>> +}
>
> cheers
Thanks!
Pratik

