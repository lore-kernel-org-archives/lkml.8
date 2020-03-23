Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038DFC10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 04:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5842206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 04:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgCWExb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 00:53:31 -0400
Received: from mail.fudan.edu.cn ([202.120.224.10]:52373 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbgCWExb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 00:53:31 -0400
Received: from localhost (unknown [120.229.255.251])
        by app1 (Coremail) with SMTP id XAUFCgA3PiquQHhe32kNAA--.6291S2;
        Mon, 23 Mar 2020 12:53:04 +0800 (CST)
Date:   Mon, 23 Mar 2020 12:53:02 +0800
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Xin Tan <tanxin.ctf@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Vishnu DASA <vdasa@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Marshall <hubcap@omnibond.com>,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, kjlu@umn.edu
Subject: Re: Re: [PATCH] VMCI: Fix NULL pointer dereference on context ptr
Message-ID: <20200323045302.GA117440@sherlly>
References: <1584426607-89366-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20200318110204.GB2305113@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318110204.GB2305113@kroah.com>
X-CM-TRANSID: XAUFCgA3PiquQHhe32kNAA--.6291S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWUAFy3Jw1kArykWr45Jrb_yoW5Cw4Upr
        ZxGFW8AFy8JF42ya9Fva1jvFyYgw1FgFyqk34Dta45ZryayFykGr4UKa4Yvr97ZF1rAr1I
        vr1UtFnxuanIyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
        0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
        Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxG
        xcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07j1iihUUUUU=
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Mar 18, 2020 at 12:02:04PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 17, 2020 at 02:29:57PM +0800, Xiyu Yang wrote:
> > The refcount wrapper function vmci_ctx_get() may return NULL
> > context ptr. Thus, we need to add a NULL pointer check
> > before its dereference.
> > 
> > Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> > Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> > ---
> >  drivers/misc/vmw_vmci/vmci_context.c    |  2 ++
> >  drivers/misc/vmw_vmci/vmci_queue_pair.c | 17 +++++++++++------
> >  2 files changed, 13 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
> > index 16695366ec92..a20878fba374 100644
> > --- a/drivers/misc/vmw_vmci/vmci_context.c
> > +++ b/drivers/misc/vmw_vmci/vmci_context.c
> > @@ -898,6 +898,8 @@ void vmci_ctx_rcv_notifications_release(u32 context_id,
> >  					bool success)
> >  {
> >  	struct vmci_ctx *context = vmci_ctx_get(context_id);
> > +	if (context == NULL)
> > +		return;
> 
> Same comment as on your other patch.
> 
> And is this a v2?

Thanks! Yes, this is a v2. 

According  to our observation, vmci_ctx_rcv_notifications_release() 
currently is only called by vmci_host_do_recv_notifications() which 
guarantees a valid context object can be acquired with this context_id. 

However, we argue that a NULL-check here is still necessary because 
this function may be called by other functions in the future who may 
fail/forget to provide such guarantee. 
A NULL-check could gracely eliminiate such assumption on the callers 
for vmci_ctx_rcv_notifications_release() with negligible overhead. 

> >  	spin_lock(&context->lock);
> >  	if (!success) {
> > diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> > index 8531ae781195..2ecb22d08692 100644
> > --- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
> > +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> > @@ -1575,11 +1575,14 @@ static int qp_broker_attach(struct qp_broker_entry *entry,
> >  		 */
> >  
> >  		create_context = vmci_ctx_get(entry->create_id);
> > -		supports_host_qp = vmci_ctx_supports_host_qp(create_context);
> > -		vmci_ctx_put(create_context);
> > +		if (!create_context) {
> > +			supports_host_qp =
> > +				vmci_ctx_supports_host_qp(create_context);
> > +			vmci_ctx_put(create_context);
> >  
> > -		if (!supports_host_qp)
> > -			return VMCI_ERROR_INVALID_RESOURCE;
> > +			if (!supports_host_qp)
> > +				return VMCI_ERROR_INVALID_RESOURCE;
> > +		}
> >  	}
> >  
> >  	if ((entry->qp.flags & ~VMCI_QP_ASYMM) != (flags & ~VMCI_QP_ASYMM_PEER))
> > @@ -1808,7 +1811,8 @@ static int qp_alloc_host_work(struct vmci_handle *handle,
> >  		pr_devel("queue pair broker failed to alloc (result=%d)\n",
> >  			 result);
> >  	}
> > -	vmci_ctx_put(context);
> > +	if (context)
> > +		vmci_ctx_put(context);
> 
> can't vmci_ctx_put() take a NULL pointer?  If not, fix this that way
> please.
> 
> thanks,
> 
> greg k-h

No. vmci_ctx_put() can not take a NULL pointer. 
Sure, we will submit a new patch to perform a NULL-check in vmci_ctx_put().

