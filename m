Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318E3C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8CF2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ujTKLPaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgCIX5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 19:57:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34975 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgCIX5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 19:57:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id g6so4670426plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 16:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wm5Lg2OwLb2Gbu8UbdOxInuFFy/j485NdtgtI1w3Uso=;
        b=ujTKLPaj9u3KLK5hwlZ/+TqVXXhRL4HdPMdOFe+PwRXGMA03qhOh3IS8bCIgGOfn+2
         zB2HKz6Oc2Ud0gyhpPcoKmfe0SfHvS1ZaACo9iJIJMjRjfeoTVIcq3CzC4Jx0kWY1w3j
         rXksS8cZMI9i4h2gNfQ+aeZ2I629bN73hLx8iUwZd60JcZgiCj0qkubn98L85GG4SKXd
         pLFl0JjNe/otONTb9RIeVrAhXgw1h+aVcVDUcObfGcAxsK9yX+CAhvPV20RrjRKYnS99
         S3LMIUDZCUYT3R75+2wunM4Hv6E5O0acqqdrKdDbiSQF7jiFImvWsL6OXMD9RiYueXfg
         ZD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wm5Lg2OwLb2Gbu8UbdOxInuFFy/j485NdtgtI1w3Uso=;
        b=N3Z1QNYJgzncArwVKGQeqHkqN+R1BqXT5i0yEVdHyihXHD4OLsKQ0saXTTHskxNawm
         J9sXncyFjwhBXHk8JsqHnw1Hmm4te0o404NaLHad6Ri7T1tOa9BN+NxPmCVJIDGG33Z7
         +WC/+P3Q0451OmIm6vVt2EN7LYtSZygxC061jPg3nuRi23cf1nOBRueCAui/eWXoiqSA
         vLlw38tvJnAbygo+RzAkSbV6gwWvCDwYS5Qqu0+7PpjYbWJVe08Z0a+nzkpu/h76C05f
         YIRL+M0k3SJv/P7H24J6hEdwia1QRzmtz2LeKBWgTWEk5whn7hbei2GMmGp3IwZt3MVx
         1hUw==
X-Gm-Message-State: ANhLgQ0WATnom8iAoKkbCJHIpGNxS8/NRseRGGhb34yXfvgZC4FzrFTH
        h+YyFXFvFhJlo+8vJ+clF4IQGg==
X-Google-Smtp-Source: ADFU+vuICM5X4u6FyXIBRBP5ZXvJd/9oP2avw/hORIe39UaN62nh9Bh5YWGsAGP95j+U/WVfFkmKtw==
X-Received: by 2002:a17:90a:1912:: with SMTP id 18mr1267198pjg.10.1583798234106;
        Mon, 09 Mar 2020 16:57:14 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 184sm12651664pfe.11.2020.03.09.16.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 16:57:13 -0700 (PDT)
Date:   Mon, 9 Mar 2020 16:57:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Clement Leger <cleger@kalray.eu>, Ohad Ben-Cohen <ohad@wizery.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-remoteproc@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>, s-anna <s-anna@ti.com>
Subject: Re: [PATCH v5 8/8] remoteproc: Adapt coredump to generate correct
 elf type
Message-ID: <20200309235710.GE14744@builder>
References: <20200210162209.23149-1-cleger@kalray.eu>
 <20200302093902.27849-1-cleger@kalray.eu>
 <20200302093902.27849-9-cleger@kalray.eu>
 <20200309203223.GE1399@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309203223.GE1399@xps15>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Mar 13:32 PDT 2020, Mathieu Poirier wrote:

> On Mon, Mar 02, 2020 at 10:39:02AM +0100, Clement Leger wrote:
> > Now that remoteproc can load an elf64, coredump elf class should be
> > the same as the loaded elf class. In order to do that, add a
> > elf_class field to rproc with default values. If an elf is loaded
> > successfully, this field will be updated with the loaded elf class.
> > Then, the coredump core code has been modified to use the generic elf
> > macro in order to create an elf file with correct class.
> > 
> > Signed-off-by: Clement Leger <cleger@kalray.eu>
> > ---
> >  drivers/remoteproc/remoteproc_core.c       | 67 ++++++++++++++++--------------
> >  drivers/remoteproc/remoteproc_elf_loader.c |  3 ++
> >  include/linux/remoteproc.h                 |  1 +
> >  3 files changed, 39 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index b932a64a2be2..f923355aa3f9 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/platform_device.h>
> >  
> >  #include "remoteproc_internal.h"
> > +#include "remoteproc_elf_helpers.h"
> >  
> >  #define HIGH_BITS_MASK 0xFFFFFFFF00000000ULL
> >  
> > @@ -1566,20 +1567,21 @@ EXPORT_SYMBOL(rproc_coredump_add_custom_segment);
> >  static void rproc_coredump(struct rproc *rproc)
> >  {
> >  	struct rproc_dump_segment *segment;
> > -	struct elf32_phdr *phdr;
> > -	struct elf32_hdr *ehdr;
> > +	void *phdr;
> > +	void *ehdr;
> >  	size_t data_size;
> >  	size_t offset;
> >  	void *data;
> >  	void *ptr;
> > +	u8 class = rproc->elf_class;
> >  	int phnum = 0;
> >  
> >  	if (list_empty(&rproc->dump_segments))
> >  		return;
> >  
> > -	data_size = sizeof(*ehdr);
> > +	data_size = elf_size_of_hdr(class);
> >  	list_for_each_entry(segment, &rproc->dump_segments, node) {
> > -		data_size += sizeof(*phdr) + segment->size;
> > +		data_size += elf_size_of_phdr(class) + segment->size;
> >  
> >  		phnum++;
> >  	}
> > @@ -1590,33 +1592,33 @@ static void rproc_coredump(struct rproc *rproc)
> >  
> >  	ehdr = data;
> >  
> > -	memset(ehdr, 0, sizeof(*ehdr));
> > -	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
> > -	ehdr->e_ident[EI_CLASS] = ELFCLASS32;
> > -	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
> > -	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
> > -	ehdr->e_ident[EI_OSABI] = ELFOSABI_NONE;
> > -	ehdr->e_type = ET_CORE;
> > -	ehdr->e_machine = EM_NONE;
> > -	ehdr->e_version = EV_CURRENT;
> > -	ehdr->e_entry = rproc->bootaddr;
> > -	ehdr->e_phoff = sizeof(*ehdr);
> > -	ehdr->e_ehsize = sizeof(*ehdr);
> > -	ehdr->e_phentsize = sizeof(*phdr);
> > -	ehdr->e_phnum = phnum;
> > -
> > -	phdr = data + ehdr->e_phoff;
> > -	offset = ehdr->e_phoff + sizeof(*phdr) * ehdr->e_phnum;
> > +	memset(ehdr, 0, elf_size_of_hdr(class));
> > +	/* e_ident field is common for both elf32 and elf64 */
> > +	elf_hdr_init_ident(ehdr, class);
> > +
> > +	elf_hdr_set_e_type(class, ehdr, ET_CORE);
> > +	elf_hdr_set_e_machine(class, ehdr, EM_NONE);
> > +	elf_hdr_set_e_version(class, ehdr, EV_CURRENT);
> > +	elf_hdr_set_e_entry(class, ehdr, rproc->bootaddr);
> > +	elf_hdr_set_e_phoff(class, ehdr, elf_size_of_hdr(class));
> > +	elf_hdr_set_e_ehsize(class, ehdr, elf_size_of_hdr(class));
> > +	elf_hdr_set_e_phentsize(class, ehdr, elf_size_of_phdr(class));
> > +	elf_hdr_set_e_phnum(class, ehdr, phnum);
> > +
> > +	phdr = data + elf_hdr_get_e_phoff(class, ehdr);
> > +	offset = elf_hdr_get_e_phoff(class, ehdr);
> > +	offset += elf_size_of_phdr(class) * elf_hdr_get_e_phnum(class, ehdr);
> > +
> >  	list_for_each_entry(segment, &rproc->dump_segments, node) {
> > -		memset(phdr, 0, sizeof(*phdr));
> > -		phdr->p_type = PT_LOAD;
> > -		phdr->p_offset = offset;
> > -		phdr->p_vaddr = segment->da;
> > -		phdr->p_paddr = segment->da;
> > -		phdr->p_filesz = segment->size;
> > -		phdr->p_memsz = segment->size;
> > -		phdr->p_flags = PF_R | PF_W | PF_X;
> > -		phdr->p_align = 0;
> > +		memset(phdr, 0, elf_size_of_phdr(class));
> > +		elf_phdr_set_p_type(class, phdr, PT_LOAD);
> > +		elf_phdr_set_p_offset(class, phdr, offset);
> > +		elf_phdr_set_p_vaddr(class, phdr, segment->da);
> > +		elf_phdr_set_p_paddr(class, phdr, segment->da);
> > +		elf_phdr_set_p_filesz(class, phdr, segment->size);
> > +		elf_phdr_set_p_memsz(class, phdr, segment->size);
> > +		elf_phdr_set_p_flags(class, phdr, PF_R | PF_W | PF_X);
> > +		elf_phdr_set_p_align(class, phdr, 0);
> >  
> >  		if (segment->dump) {
> >  			segment->dump(rproc, segment, data + offset);
> > @@ -1632,8 +1634,8 @@ static void rproc_coredump(struct rproc *rproc)
> >  			}
> >  		}
> >  
> > -		offset += phdr->p_filesz;
> > -		phdr++;
> > +		offset += elf_phdr_get_p_filesz(class, phdr);
> > +		phdr += elf_size_of_phdr(class);
> >  	}
> >  
> >  	dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
> > @@ -2031,6 +2033,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
> >  	rproc->name = name;
> >  	rproc->priv = &rproc[1];
> >  	rproc->auto_boot = true;
> > +	rproc->elf_class = ELFCLASS32;
> 
> I would initialise this to ELFCLASSNONE to make sure that if a platform driver
> overwrites rproc_elf_load_segments or doesn't provide one, we don't falsely
> deduce the elf type.  It goes without saying that if elf_class == ELFCLASSNONE,
> a coredump is not generated. 
> 

I like the idea of making the choice explicit, perhaps even more
explicit than the assumption that the coredumps should be of the same
type as the ELF loaded. Note that it's different consumers of the two
ELF files.

> Unless you think this is a seriously bad idea or Bjorn over rules me,
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 

Not sure if it count as "over ruling", I accept your suggestion but used
your R-b to merge the patch as is, no need to hold this up any longer.

Clement, can you please follow up with a patch implementing this (don't
forget that the qcom drivers doesn't use rproc_elf_load_segments())

Thanks Clement and thanks for the reviews Mathieu.

Regards,
Bjorn

> Thanks,
> Mathieu
> 
> >  
> >  	device_initialize(&rproc->dev);
> >  	rproc->dev.parent = dev;
> > diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
> > index 4869fb7d8fe4..16e2c496fd45 100644
> > --- a/drivers/remoteproc/remoteproc_elf_loader.c
> > +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> > @@ -248,6 +248,9 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
> >  			memset(ptr + filesz, 0, memsz - filesz);
> >  	}
> >  
> > +	if (ret == 0)
> > +		rproc->elf_class = class;
> > +
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL(rproc_elf_load_segments);
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index 1683d6c386a6..ed127b2d35ca 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -514,6 +514,7 @@ struct rproc {
> >  	bool auto_boot;
> >  	struct list_head dump_segments;
> >  	int nb_vdev;
> > +	u8 elf_class;
> >  };
> >  
> >  /**
> > -- 
> > 2.15.0.276.g89ea799
> > 
