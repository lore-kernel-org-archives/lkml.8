Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D369C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3842075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FaJLqd+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgG0NFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgG0NFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:05:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8A4C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RxbAGl4PUDm4c+DGHQHTJ2uim+y1519L6g39+XLZtFs=; b=FaJLqd+l1GtP1wAbA/9uo2GIb8
        7L1sZz/ejxBJtaI/ucuv9o/lar1+9BH0xP+u7P4GYhv34q9poT1TK8K3fyXf0rPlV23WHjjOt45cL
        73jOcMcEKyWnRoIukU9EebPZ+T1n5z4tqeqn2UdPbs24Dg9trqIllZh4Tb//d07nxIu+bGyNVCPFi
        pHcsGhQyROiXinMmXiszsMAmil9Mcbm9KZqmjP5x3j4ON/k+JfHAoQABO/7xVkmQJhrCJGRtpZX2Q
        jV3mQwI980/Qe+g49emd6UHaXxtHPQwUK+k6yuIbSO0VabBXiQPWxp4fiQco3D31B2jfVZBMEMd2S
        s8e7mzcw==;
Received: from [2001:4bb8:18c:2acc:aa45:8411:1fb3:30ec] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k02oR-0000JE-6t; Mon, 27 Jul 2020 13:05:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty/synclink: remove leftover bits of non-PCI card support
Date:   Mon, 27 Jul 2020 15:05:01 +0200
Message-Id: <20200727130501.31005-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1355cba9c3ba ("tty/synclink: remove ISA support"), the
synlink driver only supports PCI card.  Remove any leftover dead code
to support other cards.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/tty/synclink.c | 350 +++++++++++++----------------------------
 1 file changed, 109 insertions(+), 241 deletions(-)

diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index 08d2976593d5d6..0dba40eace46fc 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -252,7 +252,6 @@ struct mgsl_struct {
 
 	char device_name[25];		/* device instance name */
 
-	unsigned int bus_type;	/* expansion bus type (ISA,EISA,PCI) */
 	unsigned char bus;		/* expansion bus number (zero based) */
 	unsigned char function;		/* PCI device number */
 
@@ -3432,15 +3431,9 @@ static inline void line_info(struct seq_file *m, struct mgsl_struct *info)
 	char	stat_buf[30];
 	unsigned long flags;
 
-	if (info->bus_type == MGSL_BUS_TYPE_PCI) {
-		seq_printf(m, "%s:PCI io:%04X irq:%d mem:%08X lcr:%08X",
-			info->device_name, info->io_base, info->irq_level,
-			info->phys_memory_base, info->phys_lcr_base);
-	} else {
-		seq_printf(m, "%s:(E)ISA io:%04X irq:%d dma:%d",
-			info->device_name, info->io_base, 
-			info->irq_level, info->dma_level);
-	}
+	seq_printf(m, "%s:PCI io:%04X irq:%d mem:%08X lcr:%08X",
+		info->device_name, info->io_base, info->irq_level,
+		info->phys_memory_base, info->phys_lcr_base);
 
 	/* output current serial signal states */
 	spin_lock_irqsave(&info->irq_spinlock,flags);
@@ -3556,54 +3549,27 @@ static int mgsl_allocate_dma_buffers(struct mgsl_struct *info)
 	if ( info->max_frame_size % DMABUFFERSIZE )
 		BuffersPerFrame++;
 
-	if ( info->bus_type == MGSL_BUS_TYPE_PCI ) {
-		/*
-		 * The PCI adapter has 256KBytes of shared memory to use.
-		 * This is 64 PAGE_SIZE buffers.
-		 *
-		 * The first page is used for padding at this time so the
-		 * buffer list does not begin at offset 0 of the PCI
-		 * adapter's shared memory.
-		 *
-		 * The 2nd page is used for the buffer list. A 4K buffer
-		 * list can hold 128 DMA_BUFFER structures at 32 bytes
-		 * each.
-		 *
-		 * This leaves 62 4K pages.
-		 *
-		 * The next N pages are used for transmit frame(s). We
-		 * reserve enough 4K page blocks to hold the required
-		 * number of transmit dma buffers (num_tx_dma_buffers),
-		 * each of MaxFrameSize size.
-		 *
-		 * Of the remaining pages (62-N), determine how many can
-		 * be used to receive full MaxFrameSize inbound frames
-		 */
-		info->tx_buffer_count = info->num_tx_dma_buffers * BuffersPerFrame;
-		info->rx_buffer_count = 62 - info->tx_buffer_count;
-	} else {
-		/* Calculate the number of PAGE_SIZE buffers needed for */
-		/* receive and transmit DMA buffers. */
-
-
-		/* Calculate the number of DMA buffers necessary to */
-		/* hold 7 max size receive frames and one max size transmit frame. */
-		/* The receive buffer count is bumped by one so we avoid an */
-		/* End of List condition if all receive buffers are used when */
-		/* using linked list DMA buffers. */
-
-		info->tx_buffer_count = info->num_tx_dma_buffers * BuffersPerFrame;
-		info->rx_buffer_count = (BuffersPerFrame * MAXRXFRAMES) + 6;
-		
-		/* 
-		 * limit total TxBuffers & RxBuffers to 62 4K total 
-		 * (ala PCI Allocation) 
-		 */
-		
-		if ( (info->tx_buffer_count + info->rx_buffer_count) > 62 )
-			info->rx_buffer_count = 62 - info->tx_buffer_count;
-
-	}
+	/*
+	 * The PCI adapter has 256KBytes of shared memory to use.  This is 64
+	 * PAGE_SIZE buffers.
+	 *
+	 * The first page is used for padding at this time so the buffer list
+	 * does not begin at offset 0 of the PCI adapter's shared memory.
+	 *
+	 * The 2nd page is used for the buffer list. A 4K buffer list can hold
+	 * 128 DMA_BUFFER structures at 32 bytes each.
+	 *
+	 * This leaves 62 4K pages.
+	 *
+	 * The next N pages are used for transmit frame(s).  We reserve enough
+	 * 4K page blocks to hold the required number of transmit dma buffers
+	 * (num_tx_dma_buffers), each of MaxFrameSize size.
+	 *
+	 * Of the remaining pages (62-N), determine how many can be used to
+	 * receive full MaxFrameSize inbound frames
+	 */
+	info->tx_buffer_count = info->num_tx_dma_buffers * BuffersPerFrame;
+	info->rx_buffer_count = 62 - info->tx_buffer_count;
 
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk("%s(%d):Allocating %d TX and %d RX DMA buffers.\n",
@@ -3652,23 +3618,10 @@ static int mgsl_alloc_buffer_list_memory( struct mgsl_struct *info )
 {
 	unsigned int i;
 
-	if ( info->bus_type == MGSL_BUS_TYPE_PCI ) {
-		/* PCI adapter uses shared memory. */
-		info->buffer_list = info->memory_base + info->last_mem_alloc;
-		info->buffer_list_phys = info->last_mem_alloc;
-		info->last_mem_alloc += BUFFERLISTSIZE;
-	} else {
-		/* ISA adapter uses system memory. */
-		/* The buffer lists are allocated as a common buffer that both */
-		/* the processor and adapter can access. This allows the driver to */
-		/* inspect portions of the buffer while other portions are being */
-		/* updated by the adapter using Bus Master DMA. */
-
-		info->buffer_list = dma_alloc_coherent(NULL, BUFFERLISTSIZE, &info->buffer_list_dma_addr, GFP_KERNEL);
-		if (info->buffer_list == NULL)
-			return -ENOMEM;
-		info->buffer_list_phys = (u32)(info->buffer_list_dma_addr);
-	}
+	/* PCI adapter uses shared memory. */
+	info->buffer_list = info->memory_base + info->last_mem_alloc;
+	info->buffer_list_phys = info->last_mem_alloc;
+	info->last_mem_alloc += BUFFERLISTSIZE;
 
 	/* We got the memory for the buffer entry lists. */
 	/* Initialize the memory block to all zeros. */
@@ -3734,9 +3687,6 @@ static int mgsl_alloc_buffer_list_memory( struct mgsl_struct *info )
  */
 static void mgsl_free_buffer_list_memory( struct mgsl_struct *info )
 {
-	if (info->buffer_list && info->bus_type != MGSL_BUS_TYPE_PCI)
-		dma_free_coherent(NULL, BUFFERLISTSIZE, info->buffer_list, info->buffer_list_dma_addr);
-		
 	info->buffer_list = NULL;
 	info->rx_buffer_list = NULL;
 	info->tx_buffer_list = NULL;
@@ -3762,24 +3712,13 @@ static void mgsl_free_buffer_list_memory( struct mgsl_struct *info )
 static int mgsl_alloc_frame_memory(struct mgsl_struct *info,DMABUFFERENTRY *BufferList,int Buffercount)
 {
 	int i;
-	u32 phys_addr;
 
 	/* Allocate page sized buffers for the receive buffer list */
 
 	for ( i = 0; i < Buffercount; i++ ) {
-		if ( info->bus_type == MGSL_BUS_TYPE_PCI ) {
-			/* PCI adapter uses shared memory buffers. */
-			BufferList[i].virt_addr = info->memory_base + info->last_mem_alloc;
-			phys_addr = info->last_mem_alloc;
-			info->last_mem_alloc += DMABUFFERSIZE;
-		} else {
-			/* ISA adapter uses system memory. */
-			BufferList[i].virt_addr = dma_alloc_coherent(NULL, DMABUFFERSIZE, &BufferList[i].dma_addr, GFP_KERNEL);
-			if (BufferList[i].virt_addr == NULL)
-				return -ENOMEM;
-			phys_addr = (u32)(BufferList[i].dma_addr);
-		}
-		BufferList[i].phys_addr = phys_addr;
+		BufferList[i].virt_addr = info->memory_base + info->last_mem_alloc;
+		BufferList[i].phys_addr = info->last_mem_alloc;
+		info->last_mem_alloc += DMABUFFERSIZE;
 	}
 
 	return 0;
@@ -3807,8 +3746,6 @@ static void mgsl_free_frame_memory(struct mgsl_struct *info, DMABUFFERENTRY *Buf
 	if ( BufferList ) {
 		for ( i = 0 ; i < Buffercount ; i++ ) {
 			if ( BufferList[i].virt_addr ) {
-				if ( info->bus_type != MGSL_BUS_TYPE_PCI )
-					dma_free_coherent(NULL, DMABUFFERSIZE, BufferList[i].virt_addr, BufferList[i].dma_addr);
 				BufferList[i].virt_addr = NULL;
 			}
 		}
@@ -4040,58 +3977,40 @@ static int mgsl_claim_resources(struct mgsl_struct *info)
 	}
 	info->irq_requested = true;
 	
-	if ( info->bus_type == MGSL_BUS_TYPE_PCI ) {
-		if (request_mem_region(info->phys_memory_base,0x40000,"synclink") == NULL) {
-			printk( "%s(%d):mem addr conflict device %s Addr=%08X\n",
-				__FILE__,__LINE__,info->device_name, info->phys_memory_base);
-			goto errout;
-		}
-		info->shared_mem_requested = true;
-		if (request_mem_region(info->phys_lcr_base + info->lcr_offset,128,"synclink") == NULL) {
-			printk( "%s(%d):lcr mem addr conflict device %s Addr=%08X\n",
-				__FILE__,__LINE__,info->device_name, info->phys_lcr_base + info->lcr_offset);
-			goto errout;
-		}
-		info->lcr_mem_requested = true;
-
-		info->memory_base = ioremap(info->phys_memory_base,
-								0x40000);
-		if (!info->memory_base) {
-			printk( "%s(%d):Can't map shared memory on device %s MemAddr=%08X\n",
-				__FILE__,__LINE__,info->device_name, info->phys_memory_base );
-			goto errout;
-		}
-		
-		if ( !mgsl_memory_test(info) ) {
-			printk( "%s(%d):Failed shared memory test %s MemAddr=%08X\n",
-				__FILE__,__LINE__,info->device_name, info->phys_memory_base );
-			goto errout;
-		}
-		
-		info->lcr_base = ioremap(info->phys_lcr_base,
-								PAGE_SIZE);
-		if (!info->lcr_base) {
-			printk( "%s(%d):Can't map LCR memory on device %s MemAddr=%08X\n",
-				__FILE__,__LINE__,info->device_name, info->phys_lcr_base );
-			goto errout;
-		}
-		info->lcr_base += info->lcr_offset;
+	if (request_mem_region(info->phys_memory_base,0x40000,"synclink") == NULL) {
+		printk( "%s(%d):mem addr conflict device %s Addr=%08X\n",
+			__FILE__,__LINE__,info->device_name, info->phys_memory_base);
+		goto errout;
+	}
+	info->shared_mem_requested = true;
+	if (request_mem_region(info->phys_lcr_base + info->lcr_offset,128,"synclink") == NULL) {
+		printk( "%s(%d):lcr mem addr conflict device %s Addr=%08X\n",
+			__FILE__,__LINE__,info->device_name, info->phys_lcr_base + info->lcr_offset);
+		goto errout;
+	}
+	info->lcr_mem_requested = true;
+
+	info->memory_base = ioremap(info->phys_memory_base, 0x40000);
+	if (!info->memory_base) {
+		printk( "%s(%d):Can't map shared memory on device %s MemAddr=%08X\n",
+			__FILE__,__LINE__,info->device_name, info->phys_memory_base );
+		goto errout;
+	}
 		
-	} else {
-		/* claim DMA channel */
+	if ( !mgsl_memory_test(info) ) {
+		printk( "%s(%d):Failed shared memory test %s MemAddr=%08X\n",
+			__FILE__,__LINE__,info->device_name, info->phys_memory_base );
+		goto errout;
+	}
 		
-		if (request_dma(info->dma_level,info->device_name) < 0){
-			printk( "%s(%d):Can't request DMA channel on device %s DMA=%d\n",
-				__FILE__,__LINE__,info->device_name, info->dma_level );
-			goto errout;
-		}
-		info->dma_requested = true;
-
-		/* ISA adapter uses bus master DMA */		
-		set_dma_mode(info->dma_level,DMA_MODE_CASCADE);
-		enable_dma(info->dma_level);
+	info->lcr_base = ioremap(info->phys_lcr_base, PAGE_SIZE);
+	if (!info->lcr_base) {
+		printk( "%s(%d):Can't map LCR memory on device %s MemAddr=%08X\n",
+			__FILE__,__LINE__,info->device_name, info->phys_lcr_base );
+		goto errout;
 	}
-	
+	info->lcr_base += info->lcr_offset;
+		
 	if ( mgsl_allocate_dma_buffers(info) < 0 ) {
 		printk( "%s(%d):Can't allocate DMA buffers on device %s DMA=%d\n",
 			__FILE__,__LINE__,info->device_name, info->dma_level );
@@ -4200,16 +4119,10 @@ static void mgsl_add_device( struct mgsl_struct *info )
 	else if ( info->max_frame_size > 65535 )
 		info->max_frame_size = 65535;
 	
-	if ( info->bus_type == MGSL_BUS_TYPE_PCI ) {
-		printk( "SyncLink PCI v%d %s: IO=%04X IRQ=%d Mem=%08X,%08X MaxFrameSize=%u\n",
-			info->hw_version + 1, info->device_name, info->io_base, info->irq_level,
-			info->phys_memory_base, info->phys_lcr_base,
-		     	info->max_frame_size );
-	} else {
-		printk( "SyncLink ISA %s: IO=%04X IRQ=%d DMA=%d MaxFrameSize=%u\n",
-			info->device_name, info->io_base, info->irq_level, info->dma_level,
-		     	info->max_frame_size );
-	}
+	printk( "SyncLink PCI v%d %s: IO=%04X IRQ=%d Mem=%08X,%08X MaxFrameSize=%u\n",
+		info->hw_version + 1, info->device_name, info->io_base, info->irq_level,
+		info->phys_memory_base, info->phys_lcr_base,
+	     	info->max_frame_size );
 
 #if SYNCLINK_GENERIC_HDLC
 	hdlcdev_init(info);
@@ -4420,8 +4333,7 @@ static void usc_RTCmd( struct mgsl_struct *info, u16 Cmd )
 	outw( Cmd + info->loopback_bits, info->io_base + CCAR );
 
 	/* Read to flush write to CCAR */
-	if ( info->bus_type == MGSL_BUS_TYPE_PCI )
-		inw( info->io_base + CCAR );
+	inw( info->io_base + CCAR );
 
 }	/* end of usc_RTCmd() */
 
@@ -4445,8 +4357,7 @@ static void usc_DmaCmd( struct mgsl_struct *info, u16 Cmd )
 	outw( Cmd + info->mbre_bit, info->io_base );
 
 	/* Read to flush write to DCAR */
-	if ( info->bus_type == MGSL_BUS_TYPE_PCI )
-		inw( info->io_base );
+	inw( info->io_base );
 
 }	/* end of usc_DmaCmd() */
 
@@ -4475,8 +4386,7 @@ static void usc_OutDmaReg( struct mgsl_struct *info, u16 RegAddr, u16 RegValue )
 	outw( RegValue, info->io_base );
 
 	/* Read to flush write to DCAR */
-	if ( info->bus_type == MGSL_BUS_TYPE_PCI )
-		inw( info->io_base );
+	inw( info->io_base );
 
 }	/* end of usc_OutDmaReg() */
  
@@ -4528,8 +4438,7 @@ static void usc_OutReg( struct mgsl_struct *info, u16 RegAddr, u16 RegValue )
 	outw( RegValue, info->io_base + CCAR );
 
 	/* Read to flush write to CCAR */
-	if ( info->bus_type == MGSL_BUS_TYPE_PCI )
-		inw( info->io_base + CCAR );
+	inw( info->io_base + CCAR );
 
 }	/* end of usc_OutReg() */
 
@@ -4728,10 +4637,7 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
 
 	RegValue = usc_InReg( info, RICR ) & 0xc0;
 
-	if ( info->bus_type == MGSL_BUS_TYPE_PCI )
-		usc_OutReg( info, RICR, (u16)(0x030a | RegValue) );
-	else
-		usc_OutReg( info, RICR, (u16)(0x140a | RegValue) );
+	usc_OutReg( info, RICR, (u16)(0x030a | RegValue) );
 
 	/* Unlatch all Rx status bits and clear Rx status IRQ Pending */
 
@@ -4792,10 +4698,7 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
 	 *	0000 0000 0011 0110 = 0x0036
 	 */
 
-	if ( info->bus_type == MGSL_BUS_TYPE_PCI )
-		usc_OutReg( info, TICR, 0x0736 );
-	else								
-		usc_OutReg( info, TICR, 0x1436 );
+	usc_OutReg( info, TICR, 0x0736 );
 
 	usc_UnlatchTxstatusBits( info, TXSTATUS_ALL );
 	usc_ClearIrqPendingBits( info, TRANSMIT_STATUS );
@@ -4885,10 +4788,7 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
 		/*  DPLL is enabled. Use BRG1 to provide continuous reference clock  */
 		/*  for DPLL. DPLL mode in HCR is dependent on the encoding used. */
 
-		if ( info->bus_type == MGSL_BUS_TYPE_PCI )
-			XtalSpeed = 11059200;
-		else
-			XtalSpeed = 14745600;
+		XtalSpeed = 11059200;
 
 		if ( info->params.flags & HDLC_FLAG_DPLL_DIV16 ) {
 			DpllDivisor = 16;
@@ -5011,13 +4911,8 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
 	 *	0110 0000 0000 1011 = 0x600b
 	 */
 
-	if ( info->bus_type == MGSL_BUS_TYPE_PCI ) {
-		/* PCI adapter does not need DMA wait state */
-		usc_OutDmaReg( info, DCR, 0xa00b );
-	}
-	else
-		usc_OutDmaReg( info, DCR, 0x800b );
-
+	/* PCI adapter does not need DMA wait state */
+	usc_OutDmaReg( info, DCR, 0xa00b );
 
 	/* Receive DMA mode Register (RDMR)
 	 *
@@ -5109,12 +5004,8 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
 	 * <7..0>	0x00	Maximum number of clock cycles per bus grant
 	 */
 
-	if ( info->bus_type == MGSL_BUS_TYPE_PCI ) {
-		/* don't limit bus occupancy on PCI adapter */
-		usc_OutDmaReg( info, BDCR, 0x0000 );
-	}
-	else
-		usc_OutDmaReg( info, BDCR, 0x2000 );
+	/* don't limit bus occupancy on PCI adapter */
+	usc_OutDmaReg( info, BDCR, 0x0000 );
 
 	usc_stop_transmitter(info);
 	usc_stop_receiver(info);
@@ -5155,10 +5046,7 @@ static void usc_enable_loopback(struct mgsl_struct *info, int enable)
 		/* Write 16-bit Time Constant for BRG0 */
 		/* use clock speed if available, otherwise use 8 for diagnostics */
 		if (info->params.clock_speed) {
-			if (info->bus_type == MGSL_BUS_TYPE_PCI)
-				usc_OutReg(info, TC0R, (u16)((11059200/info->params.clock_speed)-1));
-			else
-				usc_OutReg(info, TC0R, (u16)((14745600/info->params.clock_speed)-1));
+			usc_OutReg(info, TC0R, (u16)((11059200/info->params.clock_speed)-1));
 		} else
 			usc_OutReg(info, TC0R, (u16)8);
 
@@ -5201,10 +5089,7 @@ static void usc_enable_aux_clock( struct mgsl_struct *info, u32 data_rate )
 	u16 Tc;
 
 	if ( data_rate ) {
-		if ( info->bus_type == MGSL_BUS_TYPE_PCI )
-			XtalSpeed = 11059200;
-		else
-			XtalSpeed = 14745600;
+		XtalSpeed = 11059200;
 
 
 		/* Tc = (Xtal/Speed) - 1 */
@@ -5682,44 +5567,38 @@ static void usc_load_txfifo( struct mgsl_struct *info )
  */
 static void usc_reset( struct mgsl_struct *info )
 {
-	if ( info->bus_type == MGSL_BUS_TYPE_PCI ) {
-		int i;
-		u32 readval;
+	int i;
+	u32 readval;
 
-		/* Set BIT30 of Misc Control Register */
-		/* (Local Control Register 0x50) to force reset of USC. */
+	/* Set BIT30 of Misc Control Register */
+	/* (Local Control Register 0x50) to force reset of USC. */
 
-		volatile u32 *MiscCtrl = (u32 *)(info->lcr_base + 0x50);
-		u32 *LCR0BRDR = (u32 *)(info->lcr_base + 0x28);
+	volatile u32 *MiscCtrl = (u32 *)(info->lcr_base + 0x50);
+	u32 *LCR0BRDR = (u32 *)(info->lcr_base + 0x28);
 
-		info->misc_ctrl_value |= BIT30;
-		*MiscCtrl = info->misc_ctrl_value;
+	info->misc_ctrl_value |= BIT30;
+	*MiscCtrl = info->misc_ctrl_value;
 
-		/*
-		 * Force at least 170ns delay before clearing 
-		 * reset bit. Each read from LCR takes at least 
-		 * 30ns so 10 times for 300ns to be safe.
-		 */
-		for(i=0;i<10;i++)
-			readval = *MiscCtrl;
-
-		info->misc_ctrl_value &= ~BIT30;
-		*MiscCtrl = info->misc_ctrl_value;
-
-		*LCR0BRDR = BUS_DESCRIPTOR(
-			1,		// Write Strobe Hold (0-3)
-			2,		// Write Strobe Delay (0-3)
-			2,		// Read Strobe Delay  (0-3)
-			0,		// NWDD (Write data-data) (0-3)
-			4,		// NWAD (Write Addr-data) (0-31)
-			0,		// NXDA (Read/Write Data-Addr) (0-3)
-			0,		// NRDD (Read Data-Data) (0-3)
-			5		// NRAD (Read Addr-Data) (0-31)
-			);
-	} else {
-		/* do HW reset */
-		outb( 0,info->io_base + 8 );
-	}
+	/*
+	 * Force at least 170ns delay before clearing reset bit.  Each read from
+	 * LCR takes at least 30ns so 10 times for 300ns to be safe.
+	 */
+	for(i=0;i<10;i++)
+		readval = *MiscCtrl;
+
+	info->misc_ctrl_value &= ~BIT30;
+	*MiscCtrl = info->misc_ctrl_value;
+
+	*LCR0BRDR = BUS_DESCRIPTOR(
+		1,		// Write Strobe Hold (0-3)
+		2,		// Write Strobe Delay (0-3)
+		2,		// Read Strobe Delay  (0-3)
+		0,		// NWDD (Write data-data) (0-3)
+		4,		// NWAD (Write Addr-data) (0-31)
+		0,		// NXDA (Read/Write Data-Addr) (0-3)
+		0,		// NRDD (Read Data-Data) (0-3)
+		5		// NRAD (Read Addr-Data) (0-31)
+		);
 
 	info->mbre_bit = 0;
 	info->loopback_bits = 0;
@@ -6228,11 +6107,7 @@ static void usc_enable_async_clock( struct mgsl_struct *info, u32 data_rate )
 		 * ClkSpeed = 921600 (ISA), 691200 (PCI)
 		 */
 
-		if ( info->bus_type == MGSL_BUS_TYPE_PCI )
-			usc_OutReg( info, TC0R, (u16)((691200/data_rate) - 1) );
-		else
-			usc_OutReg( info, TC0R, (u16)((921600/data_rate) - 1) );
-
+		usc_OutReg( info, TC0R, (u16)((691200/data_rate) - 1) );
 		
 		/*
 		 * Hardware Configuration Register (HCR)
@@ -6837,10 +6712,7 @@ static void mgsl_load_tx_dma_buffer(struct mgsl_struct *info,
 
 		/* Actually copy data from source buffer to DMA buffer. */
 		/* Also set the data count for this individual DMA buffer. */
-		if ( info->bus_type == MGSL_BUS_TYPE_PCI )
-			mgsl_load_pci_memory(pBufEntry->virt_addr, Buffer,Copycount);
-		else
-			memcpy(pBufEntry->virt_addr, Buffer, Copycount);
+		mgsl_load_pci_memory(pBufEntry->virt_addr, Buffer,Copycount);
 
 		pBufEntry->count = Copycount;
 
@@ -7315,9 +7187,6 @@ static bool mgsl_memory_test( struct mgsl_struct *info )
 	unsigned long TestLimit = SHARED_MEM_ADDRESS_SIZE/sizeof(unsigned long);
 	unsigned long * TestAddr;
 
-	if ( info->bus_type != MGSL_BUS_TYPE_PCI )
-		return true;
-
 	TestAddr = (unsigned long *)info->memory_base;
 
 	/* Test data lines with test pattern at one location. */
@@ -8003,7 +7872,6 @@ static int synclink_init_one (struct pci_dev *dev,
 	info->lcr_offset    = info->phys_lcr_base & (PAGE_SIZE-1);
 	info->phys_lcr_base &= ~(PAGE_SIZE-1);
 				
-	info->bus_type = MGSL_BUS_TYPE_PCI;
 	info->io_addr_size = 8;
 	info->irq_flags = IRQF_SHARED;
 
-- 
2.27.0

