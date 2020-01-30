Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3590C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF2E2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TdKIu4x0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgA3Mr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:47:29 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55760 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3Mr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d++GOLWtqSwAglIpfl/6MRXQSTfPsxh+M4oQnj5hels=; b=TdKIu4x0HJtQMJcRoldQ19Mkv
        ghPXPnh6Dg4C5PpxojHSPcy0G8FmGGRFJRTkwfNUhoOJ2jSRroL1aqDQtE11mokcuQ5rZ+0cXkYx8
        7bFN0r4+lTeBD/S9VmSOS+OcldZp6M1FTJ8AC6u1XcldFj0hZdYkXSgc1VEfy7TSOMnaCeCtsjlEv
        bkbpq4emqO3qStzTVc6iZINZATBZ41VWEWaSXcpmt0bCbnGoSa2t4rIPr4WnGcZgpCKJfsla+P1w+
        N+vKl5UhPPtoAycwh9p8ebS2u0QCfR/34wlDyWh7ZaNRiQ7BPTDRQsIGVwLLru/FrI+mkY35tsPNF
        94FA7KHiw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:33668)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ix9EB-0003FY-U6; Thu, 30 Jan 2020 12:47:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ix9EA-0004Om-L8; Thu, 30 Jan 2020 12:47:22 +0000
Date:   Thu, 30 Jan 2020 12:47:22 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] scripts/dtc: update fdtget.c to upstream version
 v1.4.7-57-gf267e674d145
Message-ID: <20200130124722.GJ25745@shell.armlinux.org.uk>
References: <20200130123934.3900-1-l.stelmach@samsung.com>
 <CGME20200130124251eucas1p2046004a71a1a9ff4274a6d1d96e2c260@eucas1p2.samsung.com>
 <20200130124233.4006-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200130124233.4006-1-l.stelmach@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 01:42:30PM +0100, Łukasz Stelmach wrote:
> Build and fdtget and add fdtget.c to the list of update source files.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  scripts/dtc/.gitignore           |   4 +
>  scripts/dtc/Makefile             |   5 ++
>  scripts/dtc/fdtget.c             | 125 ++++++++++++++++++-------------
>  scripts/dtc/update-dtc-source.sh |   4 +-
>  4 files changed, 82 insertions(+), 56 deletions(-)
> 
> diff --git scripts/dtc/.gitignore scripts/dtc/.gitignore
> index 2e6e60d64ede..80f6b50fdf77 100644
> --- scripts/dtc/.gitignore
> +++ scripts/dtc/.gitignore
> @@ -1 +1,5 @@
>  dtc
> +dtc-lexer.lex.c
> +dtc-parser.tab.c
> +dtc-parser.tab.h
> +fdtget
> diff --git scripts/dtc/Makefile scripts/dtc/Makefile
> index b5a5b1c548c9..74322d8dac25 100644
> --- scripts/dtc/Makefile
> +++ scripts/dtc/Makefile
> @@ -2,12 +2,15 @@
>  # scripts/dtc makefile
>  
>  hostprogs-$(CONFIG_DTC) := dtc
> +hostprogs-$(CONFIG_DTC) += fdtget
>  always		:= $(hostprogs-y)
>  
>  dtc-objs	:= dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
>  		   srcpos.o checks.o util.o
>  dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
>  
> +fdtget-objs     := fdtget.o util.o
> +
>  # Source files need to get at the userspace version of libfdt_env.h to compile
>  HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt
>  
> @@ -26,5 +29,7 @@ endif
>  HOSTCFLAGS_dtc-lexer.lex.o := -I $(srctree)/$(src)
>  HOSTCFLAGS_dtc-parser.tab.o := -I $(srctree)/$(src)
>  
> +HOSTLDLIBS_fdtget := -L$(obj)/libfdt -lfdt -Wl,-rpath='$$ORIGIN/libfdt'
> +
>  # dependencies on generated files need to be listed explicitly
>  $(obj)/dtc-lexer.lex.o: $(obj)/dtc-parser.tab.h
> diff --git scripts/dtc/fdtget.c scripts/dtc/fdtget.c
> index c922f82246c6..777582e2d45f 100644
> --- scripts/dtc/fdtget.c
> +++ scripts/dtc/fdtget.c
> @@ -39,6 +39,37 @@ static void report_error(const char *where, int err)
>  	fprintf(stderr, "Error at '%s': %s\n", where, fdt_strerror(err));
>  }
>  
> +/**
> + * Shows a list of cells in the requested format
> + *
> + * @param disp		Display information / options
> + * @param data		Data to display
> + * @param len		Maximum length of buffer
> + * @param size		Data size to use for display (e.g. 4 for 32-bit)
> + * @return 0 if ok, -1 on error
> + */
> +static int show_cell_list(struct display_info *disp, const char *data, int len,
> +			  int size)
> +{
> +	const uint8_t *p = (const uint8_t *)data;
> +	char fmt[3];
> +	int value;
> +	int i;
> +
> +	fmt[0] = '%';
> +	fmt[1] = disp->type ? disp->type : 'd';
> +	fmt[2] = '\0';
> +	for (i = 0; i < len; i += size, p += size) {
> +		if (i)
> +			printf(" ");
> +		value = size == 4 ? fdt32_ld((const fdt32_t *)p) :
> +			size == 2 ? (*p << 8) | p[1] : *p;
> +		printf(fmt, value);
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * Displays data of a given length according to selected options
>   *
> @@ -52,12 +83,9 @@ static void report_error(const char *where, int err)
>   */
>  static int show_data(struct display_info *disp, const char *data, int len)
>  {
> -	int i, size;
> -	const uint8_t *p = (const uint8_t *)data;
> +	int size;
>  	const char *s;
> -	int value;
>  	int is_string;
> -	char fmt[3];
>  
>  	/* no data, don't print */
>  	if (len == 0)
> @@ -85,17 +113,8 @@ static int show_data(struct display_info *disp, const char *data, int len)
>  				"selected data size\n");
>  		return -1;
>  	}
> -	fmt[0] = '%';
> -	fmt[1] = disp->type ? disp->type : 'd';
> -	fmt[2] = '\0';
> -	for (i = 0; i < len; i += size, p += size) {
> -		if (i)
> -			printf(" ");
> -		value = size == 4 ? fdt32_to_cpu(*(const uint32_t *)p) :
> -			size == 2 ? (*p << 8) | p[1] : *p;
> -		printf(fmt, value);
> -	}
> -	return 0;
> +
> +	return show_cell_list(disp, data, len, size);
>  }
>  
>  /**
> @@ -107,7 +126,6 @@ static int show_data(struct display_info *disp, const char *data, int len)
>   */
>  static int list_properties(const void *blob, int node)
>  {
> -	const struct fdt_property *data;
>  	const char *name;
>  	int prop;
>  
> @@ -116,8 +134,7 @@ static int list_properties(const void *blob, int node)
>  		/* Stop silently when there are no more properties */
>  		if (prop < 0)
>  			return prop == -FDT_ERR_NOTFOUND ? 0 : prop;
> -		data = fdt_get_property_by_offset(blob, prop, NULL);
> -		name = fdt_string(blob, fdt32_to_cpu(data->nameoff));
> +		fdt_getprop_by_offset(blob, prop, &name, NULL);
>  		if (name)
>  			puts(name);
>  		prop = fdt_next_property_offset(blob, prop);
> @@ -231,7 +248,7 @@ static int show_data_for_item(const void *blob, struct display_info *disp,
>   * @param filename	Filename of blob file
>   * @param arg		List of arguments to process
>   * @param arg_count	Number of arguments
> - * @param return 0 if ok, -ve on error
> + * @return 0 if ok, -ve on error
>   */
>  static int do_fdtget(struct display_info *disp, const char *filename,
>  		     char **arg, int arg_count, int args_per_step)
> @@ -240,7 +257,7 @@ static int do_fdtget(struct display_info *disp, const char *filename,
>  	const char *prop;
>  	int i, node;
>  
> -	blob = utilfdt_read(filename);
> +	blob = utilfdt_read(filename, NULL);
>  	if (!blob)
>  		return -1;
>  
> @@ -252,44 +269,50 @@ static int do_fdtget(struct display_info *disp, const char *filename,
>  				continue;
>  			} else {
>  				report_error(arg[i], node);
> +				free(blob);
>  				return -1;
>  			}
>  		}
>  		prop = args_per_step == 1 ? NULL : arg[i + 1];
>  
> -		if (show_data_for_item(blob, disp, node, prop))
> +		if (show_data_for_item(blob, disp, node, prop)) {
> +			free(blob);
>  			return -1;
> +		}
>  	}
> +
> +	free(blob);
> +
>  	return 0;
>  }
>  
> -static const char *usage_msg =
> -	"fdtget - read values from device tree\n"
> -	"\n"
> -	"Each value is printed on a new line.\n\n"
> -	"Usage:\n"
> +/* Usage related data. */
> +static const char usage_synopsis[] =
> +	"read values from device tree\n"
>  	"	fdtget <options> <dt file> [<node> <property>]...\n"
>  	"	fdtget -p <options> <dt file> [<node> ]...\n"
> -	"Options:\n"
> -	"\t-t <type>\tType of data\n"
> -	"\t-p\t\tList properties for each node\n"
> -	"\t-l\t\tList subnodes for each node\n"
> -	"\t-d\t\tDefault value to display when the property is "
> -			"missing\n"
> -	"\t-h\t\tPrint this help\n\n"
> +	"\n"
> +	"Each value is printed on a new line.\n"
>  	USAGE_TYPE_MSG;
> -
> -static void usage(const char *msg)
> -{
> -	if (msg)
> -		fprintf(stderr, "Error: %s\n\n", msg);
> -
> -	fprintf(stderr, "%s", usage_msg);
> -	exit(2);
> -}
> +static const char usage_short_opts[] = "t:pld:" USAGE_COMMON_SHORT_OPTS;
> +static struct option const usage_long_opts[] = {
> +	{"type",              a_argument, NULL, 't'},
> +	{"properties",       no_argument, NULL, 'p'},
> +	{"list",             no_argument, NULL, 'l'},
> +	{"default",           a_argument, NULL, 'd'},
> +	USAGE_COMMON_LONG_OPTS,
> +};
> +static const char * const usage_opts_help[] = {
> +	"Type of data",
> +	"List properties for each node",
> +	"List subnodes for each node",
> +	"Default value to display when the property is missing",
> +	USAGE_COMMON_OPTS_HELP
> +};
>  
>  int main(int argc, char *argv[])
>  {
> +	int opt;
>  	char *filename = NULL;
>  	struct display_info disp;
>  	int args_per_step = 2;
> @@ -298,20 +321,14 @@ int main(int argc, char *argv[])
>  	memset(&disp, '\0', sizeof(disp));
>  	disp.size = -1;
>  	disp.mode = MODE_SHOW_VALUE;
> -	for (;;) {
> -		int c = getopt(argc, argv, "d:hlpt:");
> -		if (c == -1)
> -			break;
> -
> -		switch (c) {
> -		case 'h':
> -		case '?':
> -			usage(NULL);
> +	while ((opt = util_getopt_long()) != EOF) {
> +		switch (opt) {
> +		case_USAGE_COMMON_FLAGS
>  
>  		case 't':
>  			if (utilfdt_decode_type(optarg, &disp.type,
>  					&disp.size))
> -				usage("Invalid type string");
> +				usage("invalid type string");
>  			break;
>  
>  		case 'p':
> @@ -333,7 +350,7 @@ int main(int argc, char *argv[])
>  	if (optind < argc)
>  		filename = argv[optind++];
>  	if (!filename)
> -		usage("Missing filename");
> +		usage("missing filename");
>  
>  	argv += optind;
>  	argc -= optind;
> @@ -344,7 +361,7 @@ int main(int argc, char *argv[])
>  
>  	/* Check for node, property arguments */
>  	if (args_per_step == 2 && (argc % 2))
> -		usage("Must have an even number of arguments");
> +		usage("must have an even number of arguments");
>  
>  	if (do_fdtget(&disp, filename, argv, argc, args_per_step))
>  		return 1;
> diff --git scripts/dtc/update-dtc-source.sh scripts/dtc/update-dtc-source.sh
> index 7dd29a0362b8..8db277546785 100755
> --- scripts/dtc/update-dtc-source.sh
> +++ scripts/dtc/update-dtc-source.sh
> @@ -31,8 +31,8 @@ set -ev
>  DTC_UPSTREAM_PATH=`pwd`/../dtc
>  DTC_LINUX_PATH=`pwd`/scripts/dtc
>  
> -DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c \
> -		srcpos.h treesource.c util.c util.h version_gen.h yamltree.c Makefile.dtc \
> +DTC_SOURCE="checks.c data.c dtc.c dtc.h fdtget.c flattree.c fstree.c livetree.c
> +		srcpos.c srcpos.h treesource.c util.c util.h version_gen.h Makefile.dtc \

This looks like you're dropping yamltree.c.  Is that intentional?

>  		dtc-lexer.l dtc-parser.y"
>  LIBFDT_SOURCE="Makefile.libfdt fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
>  		fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
