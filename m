Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C84C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DA22082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgBCOW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:22:58 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2357 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727802AbgBCOW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:22:58 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id CEB0FD4404B5C2881A6C;
        Mon,  3 Feb 2020 14:22:56 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Feb 2020 14:22:56 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 3 Feb 2020
 14:22:56 +0000
Date:   Mon, 3 Feb 2020 14:22:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alastair D'Silva <alastair@au1.ibm.com>
CC:     <alastair@d-silva.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Keith Busch" <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Rob Herring" <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        "=?ISO-8859-1?Q?C=E9dric?= Le Goater" <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        "Hari Bathini" <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kurz" <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v2 14/27] nvdimm/ocxl: Add support for near storage
 commands
Message-ID: <20200203142254.00007377@Huawei.com>
In-Reply-To: <20191203034655.51561-15-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
        <20191203034655.51561-15-alastair@au1.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2019 14:46:42 +1100
Alastair D'Silva <alastair@au1.ibm.com> wrote:

> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Similar to the previous patch, this adds support for near storage commands.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  drivers/nvdimm/ocxl/scm.c          |  6 +++++
>  drivers/nvdimm/ocxl/scm_internal.c | 41 ++++++++++++++++++++++++++++++
>  drivers/nvdimm/ocxl/scm_internal.h | 38 +++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+)
> 
> diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
> index 1e175f3c3cf2..6c16ca7fabfa 100644
> --- a/drivers/nvdimm/ocxl/scm.c
> +++ b/drivers/nvdimm/ocxl/scm.c
> @@ -310,12 +310,18 @@ static int scm_setup_command_metadata(struct scm_data *scm_data)
>  	int rc;
>  
>  	mutex_init(&scm_data->admin_command.lock);
> +	mutex_init(&scm_data->ns_command.lock);
>  
>  	rc = scm_extract_command_metadata(scm_data, GLOBAL_MMIO_ACMA_CREQO,
>  					  &scm_data->admin_command);
>  	if (rc)
>  		return rc;
>  
> +	rc = scm_extract_command_metadata(scm_data, GLOBAL_MMIO_NSCMA_CREQO,
> +					  &scm_data->ns_command);
> +	if (rc)
> +		return rc;
> +

Ah. So much for my comment in previous patch.  Ignore that...

>  	return 0;
>  }
>  
> diff --git a/drivers/nvdimm/ocxl/scm_internal.c b/drivers/nvdimm/ocxl/scm_internal.c
> index 7b11b56863fb..c405f1d8afb8 100644
> --- a/drivers/nvdimm/ocxl/scm_internal.c
> +++ b/drivers/nvdimm/ocxl/scm_internal.c
> @@ -132,6 +132,47 @@ int scm_admin_response_handled(const struct scm_data *scm_data)
>  				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_CHI_ACRA);
>  }
>  
> +int scm_ns_command_request(struct scm_data *scm_data, u8 op_code)
> +{
> +	u64 val;
> +	int rc = ocxl_global_mmio_read64(scm_data->ocxl_afu, GLOBAL_MMIO_CHI,
> +					 OCXL_LITTLE_ENDIAN, &val);
> +	if (rc)
> +		return rc;
> +
> +	if (!(val & GLOBAL_MMIO_CHI_NSCRA))
> +		return -EBUSY;
> +
> +	return scm_command_request(scm_data, &scm_data->ns_command, op_code);
> +}
> +
> +int scm_ns_response(const struct scm_data *scm_data)
> +{
> +	return scm_command_response(scm_data, &scm_data->ns_command);
> +}
> +
> +int scm_ns_command_execute(const struct scm_data *scm_data)
> +{
> +	return ocxl_global_mmio_set64(scm_data->ocxl_afu, GLOBAL_MMIO_HCI,
> +				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_HCI_NSCRW);
> +}
> +
> +bool scm_ns_command_complete(const struct scm_data *scm_data)
> +{
> +	u64 val = 0;
> +	int rc = scm_chi(scm_data, &val);
> +
> +	WARN_ON(rc);
> +
> +	return (val & GLOBAL_MMIO_CHI_NSCRA) != 0;
> +}
> +
> +int scm_ns_response_handled(const struct scm_data *scm_data)
> +{
> +	return ocxl_global_mmio_set64(scm_data->ocxl_afu, GLOBAL_MMIO_CHIC,
> +				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_CHI_NSCRA);
> +}
> +
>  void scm_warn_status(const struct scm_data *scm_data, const char *message,
>  		     u8 status)
>  {
> diff --git a/drivers/nvdimm/ocxl/scm_internal.h b/drivers/nvdimm/ocxl/scm_internal.h
> index 9bff684cd069..9575996a89e7 100644
> --- a/drivers/nvdimm/ocxl/scm_internal.h
> +++ b/drivers/nvdimm/ocxl/scm_internal.h
> @@ -108,6 +108,7 @@ struct scm_data {
>  	struct ocxl_context *ocxl_context;
>  	void *metadata_addr;
>  	struct command_metadata admin_command;
> +	struct command_metadata ns_command;
>  	struct resource scm_res;
>  	struct nd_region *nd_region;
>  	char fw_version[8+1];
> @@ -176,6 +177,42 @@ int scm_admin_command_complete_timeout(const struct scm_data *scm_data,
>   */
>  int scm_admin_response_handled(const struct scm_data *scm_data);
>  
> +/**
> + * scm_ns_command_request() - Issue a near storage command request
> + * @scm_data: a pointer to the SCM device data
> + * @op_code: The op-code for the command
> + * Returns an identifier for the command, or negative on error
> + */
> +int scm_ns_command_request(struct scm_data *scm_data, u8 op_code);
> +
> +/**
> + * scm_ns_response() - Validate a near storage response
> + * @scm_data: a pointer to the SCM device data
> + * Returns the status code of the command, or negative on error
> + */
> +int scm_ns_response(const struct scm_data *scm_data);
> +
> +/**
> + * scm_ns_command_execute() - Notify the controller to start processing a pending near storage command
> + * @scm_data: a pointer to the SCM device data
> + * Returns 0 on success, negative on error
> + */
> +int scm_ns_command_execute(const struct scm_data *scm_data);
> +
> +/**
> + * scm_ns_command_complete() - Is a near storage command executing
> + * scm_data: a pointer to the SCM device data
> + * Returns true if the previous admin command has completed
> + */
> +bool scm_ns_command_complete(const struct scm_data *scm_data);
> +
> +/**
> + * scm_ns_response_handled() - Notify the controller that the near storage response has been handled
> + * scm_data: a pointer to the SCM device data
> + * Returns 0 on success, negative on failure
> + */
> +int scm_ns_response_handled(const struct scm_data *scm_data);
> +
>  /**
>   * scm_warn_status() - Emit a kernel warning showing a command status.
>   * @scm_data: a pointer to the SCM device data
> @@ -184,3 +221,4 @@ int scm_admin_response_handled(const struct scm_data *scm_data);
>   */
>  void scm_warn_status(const struct scm_data *scm_data, const char *message,
>  		     u8 status);
> +
Stray blank line!

Now we are into the real nitpicks.  Not enough coffee.

Jonathan


