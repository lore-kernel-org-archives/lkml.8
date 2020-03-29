Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4D8C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 12:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB1B20733
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 12:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgC2MIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 08:08:55 -0400
Received: from mail.fudan.edu.cn ([202.120.224.73]:37937 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727938AbgC2MIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 08:08:55 -0400
Received: from localhost (unknown [120.229.255.87])
        by app2 (Coremail) with SMTP id XQUFCgA3F0i3j4BeU62DAA--.2132S2;
        Sun, 29 Mar 2020 20:08:25 +0800 (CST)
Date:   Sun, 29 Mar 2020 20:08:22 +0800
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Adit Ranadive <aditr@vmware.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishnu DASA <vdasa@vmware.com>, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH v2] VMCI: Fix NULL pointer dereference on context ptr
Message-ID: <20200329120822.GA7610@sherlly>
References: <1584951832-120773-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20200323085241.GA342330@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323085241.GA342330@kroah.com>
X-CM-TRANSID: XQUFCgA3F0i3j4BeU62DAA--.2132S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1DuF17Xr43Zw1kuw4kZwb_yoW5XF1kpF
        43Wa92yF18GFy5tayqy3WYvryFgw1fZFyqyw1qga45Zry7KFnrWr17KayYyr9xuF4Fy347
        AF1Y9a43XrZ8C3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On Mon, Mar 23, 2020 at 09:52:41AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 23, 2020 at 04:22:33PM +0800, Xiyu Yang wrote:
> > A NULL vmci_ctx object may pass to vmci_ctx_put() from its callers.
> 
> Are you sure this can happen?

Yes. We reviewed all callers of vmci_ctx_put(), and confirmed that 
at least 3 callers may pass a NULL vmci_ctx object to vmci_ctx_put().
 
Given the following qp_broker_attach() as an example, we find 
vmci_ctx_get() may return NULL, as confirmed the NULL check performed 
by vmci_ctx_supports_host_qp(). 
Thus, we believe a NULL check for vmci_ctx_put() is also necessary.

void qp_broker_attach(struct qp_broker_entry *entry,...)
{
	...
	create_context = vmci_ctx_get(entry->create_id); /* may be NULL */
	supports_host_qp = vmci_ctx_supports_host_qp(create_context); /* do NULL-check inside */ 
	vmci_ctx_put(create_context);  /* lack NULL-check */ 
	...
}

bool vmci_ctx_supports_host_qp(struct vmci_ctx *context)
{
	/* NULL-check before pointer dereference */
	return context && context->user_version >= VMCI_VERSION_HOSTQP;  
}

void vmci_ctx_put(struct vmci_ctx *context)
{
	/* A potential NULL pointer will be accessed to get context's refcount field */
	kref_put(&context->kref, ctx_free_ctx);
}

Similary situtations are confirmed for other two callers of vmci_ctx_put(): 
qp_detatch_host_work(), qp_alloc_host_work(). 

static int qp_detatch_host_work(struct vmci_handle handle)
{
	int result;
	struct vmci_ctx *context;

	context = vmci_ctx_get(VMCI_HOST_CONTEXT_ID); /* may be NULL */
	result = vmci_qp_broker_detach(handle, context); /* do NULL-check inside */
	vmci_ctx_put(context); /* lack NULL-check */
	return result;
}

static int qp_alloc_host_work(...)
{
	...
	context = vmci_ctx_get(VMCI_HOST_CONTEXT_ID); /* may be NULL */
	...
	result = qp_broker_alloc(...,context,...); /* if context == NULL, result != VMCI_SUCCESS */
	if (result == VMCI_SUCCESS) {
		...
	} else {
		*handle = VMCI_INVALID_HANDLE;
		pr_devel("queue pair broker failed to alloc (result=%d)\n",
			 result);
	}
	vmci_ctx_put(context); /* lack NULL-check */
	return result;
}

Considering vmci_ctx_supports_host_qp() performs an internal 
NULL check on vmci_ctx pointer, is it also appropriate to 
perform the NULL check inside vmci_ctx_put()?

> 
> > Add a NULL check to prevent NULL pointer dereference.
> > 
> > Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> > Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> > ---
> >  drivers/misc/vmw_vmci/vmci_context.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> What changed from v1?
> 
> Always put that below the --- line.
> 
> Please fix up and send a v3.
> 
> thanks,
> 
> greg k-h

