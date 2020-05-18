Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1375C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F14B20756
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589814967;
	bh=5opz+foPit1dH2Iwf+ULro2z9H3PIrgkxp5mEKF1PRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mdKX9+ARJsuI3aEBKpdmVHB98c+AyNWn51fhNL6rUoMsSW8uD5aplpEoUFCqxizDl
	 0koe+bF+GxEc+ixesN1MJxltNF0Rc4QCqd1hRJg8SDEZIegfOuOHtJDU+q7bKl3MNY
	 rC98K33I6H7crtTqLw2ABz1z6HGNcMh7AW3mvqXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgERPQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgERPQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:16:06 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED2A420671;
        Mon, 18 May 2020 15:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589814966;
        bh=5opz+foPit1dH2Iwf+ULro2z9H3PIrgkxp5mEKF1PRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vd5NIW+PIgRZpJFFltoGmbc3oaa1v9PZburPWhRNtRxE8F+EE82sEfPbuKvW7qqTx
         YoCVEljaw9eOCfGXyoeVdodWrzfLCHHV5vFeukYytkv7pQrIbJvDwsSd8iapXLj2ia
         9r9ga1MqzhKmCIxoYQ1bfLxz22GJyvl72NJgeX1E=
Date:   Mon, 18 May 2020 11:16:04 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200518151604.GC33628@sasha-vm>
References: <20200511045311.4785-1-sashal@kernel.org>
 <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
 <20200515164013.GF29995@sasha-vm>
 <87o8qly3jo.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87o8qly3jo.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 11:51:07AM +0200, Thomas Gleixner wrote:
>Sasha Levin <sashal@kernel.org> writes:
>> On Fri, May 15, 2020 at 12:24:14PM +0300, Jarkko Sakkinen wrote:
>>>
>>>Can you put me to the CC-loop for this patches. Some SGX-enabled
>>>frameworks such as Graphene use out-of-tree changes to achieve this.
>>>That's where the interest to possibly test this comes from.
>>
>> Indeed, we've seen a few hacks that basically just enable FSGSBASE:
>>
>>  - https://github.com/oscarlab/graphene-sgx-driver
>>  - https://github.com/occlum/enable_rdfsbase
>
>I'm really amazed by all these security experts enabling a full root
>hole. It clearly puts the SGX hypocrisy into perspective.

We can bash Intel all we want here, but sadly there are users in the
"wild" who just enable these root holes thinking they're secure, and
those users are the ones running very sensitive workloads. Here's an
example from a book called "Responsible Genomic Data Sharing":

	https://books.google.com/books?id=y6zWDwAAQBAJ&pg=PA184#v=onepage&q&f=false

That explains how to use Graphene-SGX which just enables FSGSBASE with
root holes.

Maybe it's just me, but I'd love to have my genomic data stored and
processed on systems that are actually secure :)

-- 
Thanks,
Sasha
