Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32159C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC7720707
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ff+Aldsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgFZRZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:25:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35040 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFZRZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:25:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05QHMYvR009908;
        Fri, 26 Jun 2020 17:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ftdr6mHim54L1C0LjxRdGjksokmlNmltTbluVqJWzgg=;
 b=ff+AldsaEEavTREY/UndN4fxK9RRCxWg6o7vMnL9Jr+465fnvPdA8INlJTr9fdoROhcn
 eonn5wv+4p1LxIVUTknAE2AVQTpTwZ6/dhkF0EB0CB2fsjIZqlzXrfVaEH5yGV8bMq5N
 pJ+IbL1tVs9GSsRSRPdKD7X3MidA+wnWohu1dW2cfXcmqzb5CrNg918MkZWy14LkVGPt
 o56EddzV2FsiSc9AIFmGJm8LWeFrF1jFEfIgMnww7SNvNK30WqS+mmVctGJY31XjW/XI
 Jj5D580JHjA/IdzgaOpK89Dw3GE9EmRA+75YJN0P+VbK7lupWuERZvkjQjWGUSkpZG2i Wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31uusu79b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Jun 2020 17:24:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05QHMM9v098753;
        Fri, 26 Jun 2020 17:24:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31uurctv1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jun 2020 17:24:32 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05QHORRU016433;
        Fri, 26 Jun 2020 17:24:27 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Jun 2020 17:24:20 +0000
Date:   Fri, 26 Jun 2020 20:24:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: Re: [PATCH RFC 2/5] usb:cdns3: Add pci to platform driver wrapper
Message-ID: <20200626172411.GE2571@kadam>
References: <20200626045450.10205-1-pawell@cadence.com>
 <20200626045450.10205-3-pawell@cadence.com>
 <20200626114057.GD2571@kadam>
 <DM6PR07MB5529E239FBA41BDDB52CAFC4DD930@DM6PR07MB5529.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR07MB5529E239FBA41BDDB52CAFC4DD930@DM6PR07MB5529.namprd07.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9664 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9664 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 cotscore=-2147483648 malwarescore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 03:10:32PM +0000, Pawel Laszczak wrote:
> >> +static int cdnsp_pci_probe(struct pci_dev *pdev,
> >> +			   const struct pci_device_id *id)
> >> +{
> >> +	struct platform_device_info plat_info;
> >> +	struct cdnsp_wrap *wrap;
> >> +	struct resource *res;
> >> +	struct pci_dev *func;
> >> +	int err;
> >> +
> >> +	/*
> >> +	 * For GADGET/HOST PCI (devfn) function number is 0,
> >> +	 * for OTG PCI (devfn) function number is 1.
> >> +	 */
> >> +	if (!id || (pdev->devfn != PCI_DEV_FN_HOST_DEVICE &&
> >> +		    pdev->devfn != PCI_DEV_FN_OTG))
> >> +		return -EINVAL;
> >> +
> >> +	func = cdnsp_get_second_fun(pdev);
> >> +	if (unlikely(!func))
> >> +		return -EINVAL;
> >> +
> >> +	if (func->class == PCI_CLASS_SERIAL_USB_XHCI ||
> >> +	    pdev->class == PCI_CLASS_SERIAL_USB_XHCI)
> >> +		return -EINVAL;
> >
> >
> >Do we need call pci_put_device(func) before returning?
> 
> We don't need.
> Such function doesn't exist.
> 

I meant pci_dev_put().  I'm pretty sure that we do need it to match the
pci_get_device() in cdnsp_get_second_fun().

regards,
dan carpenter

