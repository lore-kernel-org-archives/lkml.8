Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9349C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E1124671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MfKsFjnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbgAOWcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:32:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33488 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgAOWcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:32:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FMNTgE079402;
        Wed, 15 Jan 2020 22:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=bDGmmKR62/rJKWPi34OdOSl+RPEPQlXQTRCeFzErCqM=;
 b=MfKsFjnbwldOfD5DDxHQsHKZ6DKZnu+MD748kT200mUWlMIsHinIqSLG9IFdcGQPYMW+
 gWz8F+ntGj08/KuMHKE2fqe18uCplprZSeDMEd0GwMr/KPuo4qC4kZrfN7XUCNOqNqcQ
 IcAcYVNHMynsLY8lNK0XFDgnHUNLlAbNQLVx0EUKWaY2IJM9l4tKJ3LBzjwGasoBcIk6
 2UTMzJE6emrOgXrm1D+nQb1Qc7p4+/DxTSWpKRPuMIez1f5SOLbnQko6nkKEbdjzgwF/
 BjaM23LV+mQMBwlQkcT1Xi1KvibdYGu1Xi2ZbHwmQJvXRinZepIOChJQ18RzpJq67NlX ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xf73ty2ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 22:32:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00FMNZgZ178613;
        Wed, 15 Jan 2020 22:32:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2xj61kh35t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 22:32:37 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00FMWZ3d020744;
        Wed, 15 Jan 2020 22:32:36 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 14:32:34 -0800
Subject: Re: [Xen-devel] [PATCH v4] xen-pciback: optionally allow interrupt
 enable flag writes
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        open list <linux-kernel@vger.kernel.org>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        Jan Beulich <jbeulich@suse.com>
References: <20200115014643.12749-1-marmarek@invisiblethingslab.com>
 <20200115164815.GO11756@Air-de-Roger>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <393ff73f-802c-9f1c-b739-4476388b6c98@oracle.com>
Date:   Wed, 15 Jan 2020 17:32:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200115164815.GO11756@Air-de-Roger>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/20 11:48 AM, Roger Pau Monné wrote:
> On Wed, Jan 15, 2020 at 02:46:29AM +0100, Marek Marczykowski-Górecki wrote:
>> QEMU running in a stubdom needs to be able to set INTX_DISABLE, and the
>> MSI(-X) enable flags in the PCI config space. This adds an attribute
>> 'allow_interrupt_control' which when set for a PCI device allows writes
>> to this flag(s). The toolstack will need to set this for stubdoms.
>> When enabled, guest (stubdomain) will be allowed to set relevant enable
>> flags, but only one at a time - i.e. it refuses to enable more than one
>> of INTx, MSI, MSI-X at a time.
>>
>> This functionality is needed only for config space access done by device
>> model (stubdomain) serving a HVM with the actual PCI device. It is not
>> necessary and unsafe to enable direct access to those bits for PV domain
>> with the device attached. For PV domains, there are separate protocol
>> messages (XEN_PCI_OP_{enable,disable}_{msi,msix}) for this purpose.
>> Those ops in addition to setting enable bits, also configure MSI(-X) in
>> dom0 kernel - which is undesirable for PCI passthrough to HVM guests.
>>
>> This should not introduce any new security issues since a malicious
>> guest (or stubdom) can already generate MSIs through other ways, see
>> [1] page 8. Additionally, when qemu runs in dom0, it already have direct
>> access to those bits.
>>
>> This is the second iteration of this feature. First was proposed as a
>> direct Xen interface through a new hypercall, but ultimately it was
>> rejected by the maintainer, because of mixing pciback and hypercalls for
>> PCI config space access isn't a good design. Full discussion at [2].
>>
>> [1]: https://invisiblethingslab.com/resources/2011/Software%20Attacks%20on%20Intel%20VT-d.pdf
>> [2]: https://xen.markmail.org/thread/smpgpws4umdzizze
>>
>> [part of the commit message and sysfs handling]
>> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
>> [the rest]
>> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Some minor nits below, but LGTM:
>
> Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
>
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-pciback b/Documentation/ABI/testing/sysfs-driver-pciback
>> index 6a733bfa37e6..566a11f2c12f 100644
>> --- a/Documentation/ABI/testing/sysfs-driver-pciback
>> +++ b/Documentation/ABI/testing/sysfs-driver-pciback
>> @@ -11,3 +11,16 @@ Description:
>>                   #echo 00:19.0-E0:2:FF > /sys/bus/pci/drivers/pciback/quirks
>>                   will allow the guest to read and write to the configuration
>>                   register 0x0E.
>> +
>> +What:           /sys/bus/pci/drivers/pciback/allow_interrupt_control
>> +Date:           Jan 2020
>> +KernelVersion:  5.5

5.6

I can fix this and the things that Roger mentioned while committing if 
Marek is OK with that.

-boris



