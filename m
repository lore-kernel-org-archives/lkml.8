Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521ECC33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175F32084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DriF7U/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgAMVZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:25:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48236 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgAMVZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 16:25:30 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DLD57N106965;
        Mon, 13 Jan 2020 21:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=cHsTBdtsjyMBjpEmHOMBIzAOK2aybGLClLw5Dw0FMU4=;
 b=DriF7U/x59tUMa4a+ruGdgyK71k7z75JA6gSo/bwcgE6z1Md1T07cRERw+GQRJBY4wgw
 m0NU/wsqh1AwV7Z8aIrw2cMHbwvmAly1stpAZdtEV3g/3WG4NlYBLmS51aLnUBbD5HYf
 UGhZf+Fgbma4ykUqICsDDIRAlk7mLSGGI0GPrmuuZuuf8cZbEct5FEtsvlhMrnBwIgEs
 bXGw31kI6oH+142j8LLkuoPLcTit1MIYt5rDJT6ia4bq32vgZpvAYcwTqXqPw5VvN85h
 iuXKtnzI1AYgSzzddpNtpVmxcjDeE1aXNZeorJqeZH2Z+uxNoZvS87GN3DumiQaKO5bT QQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xf73thqs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 21:25:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DLEnrf174468;
        Mon, 13 Jan 2020 21:25:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xfrh6qwf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 21:25:07 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00DLP31N022435;
        Mon, 13 Jan 2020 21:25:04 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 13:25:03 -0800
Subject: Re: [PATCH v3] xen-pciback: optionally allow interrupt enable flag
 writes
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org
Cc:     Jan Beulich <jbeulich@suse.com>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20200111034347.5270-1-marmarek@invisiblethingslab.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <9ea42829-6a1a-09eb-9d59-67a0487980b6@oracle.com>
Date:   Mon, 13 Jan 2020 16:25:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200111034347.5270-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=747
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=808 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/20 10:43 PM, Marek Marczykowski-Górecki wrote:
> @@ -117,6 +117,24 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
>   		pci_clear_mwi(dev);
>   	}
>   
> +	if (dev_data && dev_data->allow_interrupt_control) {
> +		if ((cmd->val ^ val) & PCI_COMMAND_INTX_DISABLE) {
> +			if (value & PCI_COMMAND_INTX_DISABLE) {
> +				pci_intx(dev, 0);
> +			} else {
> +				/* Do not allow enabling INTx together with MSI or MSI-X. */
> +				switch (xen_pcibk_get_interrupt_type(dev)) {
> +				case INTERRUPT_TYPE_NONE:
> +				case INTERRUPT_TYPE_INTX:
> +					pci_intx(dev, 1);

If INTERRUPT_TYPE_INTX , why call pci_intx(1)?

(I think I asked this last time as well).


-boris


